part of 'category_cubit.dart';

@immutable
abstract class CategoryDataStatus {}

class CategoryDataInitial extends CategoryDataStatus {}

class CategoryDataLoading extends CategoryDataStatus {}

class CategoryDataCompleted extends CategoryDataStatus {
  final CategoriesModel categoriesModel;
  CategoryDataCompleted(this.categoriesModel);
}

class CategoryDataError extends CategoryDataStatus {
  final String errorMessage;
  CategoryDataError(this.errorMessage);
}
