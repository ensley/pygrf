import numpy as np

from cython.operator cimport dereference as deref
from cython.operator cimport address

from utils cimport DefaultData


cdef class _Data:
    cdef DefaultData *data

    def __cinit__(self, double[:,:] X, double[:] y):
        cdef unsigned int n = X.shape[0]
        cdef unsigned int p = X.shape[1]

        assert len(y) == n
        self.data = new DefaultData(np.c_[X, y].flatten('F'), n, p + 1)

    def get(self, size_t row, size_t col):
        return self.data.get(row, col)

    def set(self, size_t col, size_t row, double value):
        cdef bint err
        cdef bint* error = &err
        self.data.set(col, row, value, error[0])

    def __dealloc__(self):
        del self.data



