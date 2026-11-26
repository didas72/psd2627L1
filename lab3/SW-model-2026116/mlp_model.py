"""
Reference (software) model of Lab. Proj. 3 - MLP Classifier for MNIST
PSD 2026/27 - Prof. Guilherme Paim & Prof. Paulo Flores

Classifies a 28 x 28 image (PGM P2 format, 4-bit pixels) with a two-layer
fully-connected MLP:

    layer 0:  h[m] = ReLU( sum_k  w0[m][k] * Input[k] )        m = 0..127
    layer 1:  o[j] = sum_m ( w1[j][m] * h[m] ) / 32            j = 0..9
    result:   result = argmax(o)   (first maximum, in case of a tie)

All computations use integers, as in the hardware circuit, so that the
values of h, o and result can be compared with the testbench.

Usage:
    python p2_pgm_to_classify_model.py <image.pgm> <m0.txt> <m1.txt> [shift|trunc|sum]
"""

import numpy as np
import sys

# ---------------------------------------------------------------------------
# How the division by 32 is done in layer 1 (can be changed here or with the
# 4th command-line argument). The three modes gave the same classification
# on the test images, but the values of o can differ by a few units (each
# truncated product loses less than 1, so the difference grows with the
# number of non-zero values of h):
#   'shift' : (w1[j][m] * h[m]) >> 5 on each product. Arithmetic shift right
#             by 5 bits. This is what a circuit does when it discards the
#             5 least significant bits.
#   'trunc' : (w1[j][m] * h[m]) / 32 on each product, truncating towards
#             zero, as the integer division of the C language.
#   'sum'   : adds all the products and only at the end does >> 5 (no loss
#             of precision in the products, but the accumulator needs more
#             bits).
# ---------------------------------------------------------------------------
DIV_MODE = 'shift'


def load_pgm_p2(path):
    """Reads a PGM image in P2 (ASCII) format and returns a 28 x 28 matrix.

    P2 format: a line 'P2', then 'width height', then the maximum value and
    finally the pixel values separated by spaces. Lines starting with '#'
    are comments and are ignored.
    """
    with open(path, 'r') as f:
        lines = f.readlines()

    # Remove the comment lines
    lines = [l for l in lines if not l.startswith('#')]

    # Check that it is an ASCII PGM
    if lines[0].strip() != 'P2':
        raise ValueError("Formato inválido. Esperado P2 (ASCII).")

    # Image size and maximum value declared in the header
    width, height = map(int, lines[1].strip().split())
    maxval = int(lines[2].strip())

    # Gather all the pixel values in a single list
    pixel_data = []
    for line in lines[3:]:
        pixel_data.extend(map(int, line.strip().split()))

    if len(pixel_data) != width * height:
        raise ValueError("Número de pixels não bate com dimensões declaradas.")

    # Pixels are 4-bit unsigned integers: they can only be 0..15
    pixels = np.array(pixel_data, dtype=np.int64)
    if pixels.min() < 0 or pixels.max() > 15:
        raise ValueError("Pixels devem estar entre 0 e 15 (4 bits sem sinal).")

    return pixels.reshape((height, width))


def layer1(w1, h, mode):
    """Layer 1: o[j] = sum_m (w1[j][m] * h[m]) / 32, for j = 0..9.

    w1 is the 10 x 128 matrix and h the vector of 128 values (after ReLU).
    'mode' selects how the division by 32 is done (see DIV_MODE above).
    """
    # 10 x 128 matrix with all the products w1[j][m] * h[m]
    # (h is repeated for each of the 10 rows of w1)
    p = w1 * h[np.newaxis, :]

    if mode == 'shift':
        # Shift each product right by 5 bits and add along each row
        return np.sum(p >> 5, axis=1)
    if mode == 'trunc':
        # Divide each product by 32 truncating towards zero (as in C):
        # divide the absolute value and restore the sign
        return np.sum(np.sign(p) * (np.abs(p) // 32), axis=1)
    if mode == 'sum':
        # First add the 128 products and only then shift by 5 bits
        return np.sum(p, axis=1) >> 5
    raise ValueError("DIV_MODE inválido.")


def main():
    # --- Command-line arguments ----------------------------------------------
    if len(sys.argv) < 4:
        print("Uso: python p2_pgm_to_classify_model.py <arquivo_input.pgm> "
              "<arquivo_w0.txt> <arquivo_w1.txt> [shift|trunc|sum]")
        sys.exit(1)

    # Input image (28 x 28, pixels 0..15)
    input_matrix = load_pgm_p2(sys.argv[1])

    # How to divide by 32 (optional, 4th argument)
    mode = sys.argv[4] if len(sys.argv) > 4 else DIV_MODE

    # --- Weights -------------------------------------------------------------
    # The files contain 8-bit two's complement integers (-128..127), stored
    # row by row:
    #   m0.txt: w0 with 128 x 784 values (one row per neuron of layer 0)
    #   m1.txt: w1 with  10 x 128 values (one row per digit 0..9)
    w0 = np.loadtxt(sys.argv[2], dtype=np.int64).reshape(128, 784)
    w1 = np.loadtxt(sys.argv[3], dtype=np.int64).reshape(10, 128)

    # --- Input ---------------------------------------------------------------
    # The image is read row by row and flattened into a vector of 784 pixels:
    # Input[k], with k = 28 * row + column
    input_vector = input_matrix.reshape(-1)

    print("\nW0 matrix:\n", w0)
    print("=========================================\n")
    print("\nW1 matrix:\n", w1)
    print("=========================================\n")
    print("\nInput matrix:\n", input_matrix)
    print("=========================================\n")

    # --- Layer 0: matrix-vector product --------------------------------------
    # acc[m] = sum_k w0[m][k] * Input[k], for m = 0..127
    # (this is the accumulator of the inner loop of the pseudocode,
    #  before the ReLU)
    acc = w0 @ input_vector
    print("\n[Layer 0] MatMul (acc):\n", acc)
    print("=========================================\n")

    # --- Layer 0: ReLU -------------------------------------------------------
    # h[m] = acc[m] if acc[m] >= 0, otherwise 0
    h = np.maximum(0, acc)
    print("[Layer 0] ReLU (h):\n", h)
    print("=========================================\n")

    # --- Layer 1: matrix-vector product with division by 32 ------------------
    # o[j] = sum_m (w1[j][m] * h[m]) / 32, for j = 0..9
    # In hardware, each h[m] is used as soon as it is ready (overlapped
    # layers); the final result of o is the same.
    o = layer1(w1, h, mode)
    print(f"[Layer 1] MatMul / 32 (o)  [divisao: {mode}]:\n", o)
    print("=========================================\n")

    # --- Classification ------------------------------------------------------
    # result = index of the largest o[j]. np.argmax returns the first
    # maximum, as the pseudocode (o[j] > o[result]) does in case of a tie.
    result = int(np.argmax(o))
    print("[Argmax] Classe predita:", result)
    print("=========================================\n")


if __name__ == '__main__':
    main()
