import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../common/resources/data_state.dart';
import '../../../data/models/categories_model.dart';
import '../../../repositories/category_repository.dart';

part 'category_state.dart';
part 'category_data_status.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository categoryRepository;
  CategoryCubit(this.categoryRepository) : super(CategoryState(categoryDataStatus: CategoryDataLoading()));


  Future<void> loadCategoryEvent() async {
    /// emit loading
    emit(state.copyWith(newCategoryDataStatus: CategoryDataLoading()));

    DataState dataState = await categoryRepository.fetchCategoryData();

    if(dataState is DataSuccess){
      /// emit completed
      emit(state.copyWith(newCategoryDataStatus: CategoryDataCompleted(dataState.data)));
    }

    if(dataState is DataFailed){
      /// emit error
      emit(state.copyWith(newCategoryDataStatus: CategoryDataError(dataState.error!)));
    }
  }
}
