import unittest

import numpy as np

from CausalForest import _Data


class MyTestCase(unittest.TestCase):
    def test_something(self):
        n = 1000
        np.random.seed(42)
        X = np.random.randn(n, 5)
        y = np.random.randn(n)
        data = _Data(X, y)
        self.assertEqual(X[0, 1], data.get(0, 1))
        data.set(1, 0, 5)
        self.assertEqual(5, data.get(0, 1))


if __name__ == '__main__':
    unittest.main()
