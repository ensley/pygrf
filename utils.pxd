from libcpp.vector cimport vector
from libcpp.memory cimport unique_ptr
from libcpp.set cimport set as _set
from libcpp cimport bool

cdef extern from "commons/Data.h" namespace "grf":
    cdef cppclass Data:
        Data()
        void reserve_memory()
        double get(size_t row, size_t col)
        void set(size_t col, size_t row, double value, bool& error)
        void set_outcome_index(size_t index)
        void set_treatment_index(size_t index)
        void set_instrument_index(size_t index)
        void set_weight_index(size_t index)
        void get_all_values(vector[double]& all_values,
                            vector[size_t]& sorted_samples,
                            vector[size_t]& samples,
                            size_t var)
        size_t get_num_cols()
        size_t get_num_rows()
        double get_outcome(size_t row)
        double get_treatment(size_t row)
        double get_instrument(size_t row)
        double get_weight(size_t row)
        _set[size_t] get_disallowed_split_variables()


cdef extern from "commons/DefaultData.h" namespace "grf":
    cdef cppclass DefaultData(Data):
        DefaultData() except +
        DefaultData(const vector[double]& data,
                    size_t num_rows,
                    size_t num_cols) except +


cdef extern from "commons/SparseData.h" namespace "grf":
    cdef cppclass SparseData(Data):
        SparseData()
        SparseData(const vector[double]& data,
                   size_t num_rows,
                   size_t num_cols)


cdef extern from "prediction/OptimizedPredictionStrategy.h" namespace "grf":
    cdef cppclass OptimizedPredictionStrategy:
        pass


cdef extern from "relabeling/RelabelingStrategy.h" namespace "grf":
    cdef cppclass RelabelingStrategy:
        pass


cdef extern from "splitting/factory/SplittingRuleFactory.h" namespace "grf":
    cdef cppclass SplittingRuleFactory:
        pass


cdef extern from "forest/Forest.h" namespace "grf":
    cdef cppclass Forest:
        pass


cdef extern from "forest/ForestOptions.h" namespace "grf":
    cdef cppclass ForestOptions:
        pass


cdef extern from "forest/ForestTrainer.h" namespace "grf":
    cdef cppclass ForestTrainer:
        ForestTrainer()
        ForestTrainer(unique_ptr[RelabelingStrategy] relabeling_strategy,
                      unique_ptr[SplittingRuleFactory] splitting_rule_factory,
                      unique_ptr[OptimizedPredictionStrategy] prediction_strategy)
        Forest train(const Data& data, const ForestOptions& options)


cdef extern from "forest/ForestTrainers.h" namespace "grf":
    ForestTrainer instrumental_trainer(double reduced_form_weight,
                                       bint stabilize_splits)
