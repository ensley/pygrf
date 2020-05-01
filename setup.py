from distutils.core import setup, Extension
from Cython.Build import cythonize

compile_args = ['-g', '-std=c++11']

GRF_SOURCES = [
    'core/src/commons/Data.cpp',
    'core/src/commons/DefaultData.cpp',
    'core/src/commons/SparseData.cpp',
    'core/src/commons/utility.cpp'
]

ext = Extension('CausalForest',
                sources=['CausalForest.pyx'] + GRF_SOURCES,
                include_dirs=['core/src', 'core/third_party'],
                extra_compile_args=compile_args,
                language='c++')

setup(name='CausalForest',
      ext_modules=cythonize(ext, compiler_directives={'language_level': 3}))
