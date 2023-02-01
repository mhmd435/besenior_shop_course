part of 'category_cubit.dart';

class CategoryState {
  CategoryDataStatus categoryDataStatus;

  CategoryState({required this.categoryDataStatus});

  CategoryState copyWith({
    CategoryDataStatus? newCategoryDataStatus,
  }){
    return CategoryState(
        categoryDataStatus: newCategoryDataStatus ?? categoryDataStatus
    );
  }
}

