import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../common/params/products_params.dart';
import '../../../../../common/resources/data_state.dart';
import '../../../data/models/all_products_model.dart';
import '../../../repositories/all_product_repository.dart';

part 'all_products_state.dart';
part 'products_data_status.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsRepository allProductsRepository;
  AllProductsCubit(this.allProductsRepository) : super(AllProductsState(
      productsDataStatus: ProductsDataLoading(),
      allProducts: [],
      nextStart: 0,
      isLoadingPaging: false
  ));


  Future<void> loadProductsData(ProductsParams productsParams) async {
    /// emit loading
    /// if it is first time emit main loading
    /// if it is paging time emit paging loading
    if(state.nextStart == 0){
      emit(state.copyWith(newProductsDataStatus: ProductsDataLoading()));
    }else{
      emit(state.copyWith(newIsLoadingPaging: true));
    }

    /// change next start before api call
    productsParams.start = state.nextStart;
    DataState dataState = await allProductsRepository.fetchAllProductsData(productsParams);

    if(dataState is DataSuccess){
      AllProductsModel allProductsModel = dataState.data;

      /// emit completed
      emit(state.copyWith(
        newProductsDataStatus: ProductsDataCompleted(allProductsModel),
        newAllProducts: state.allProducts..addAll(allProductsModel.data![0].products!),
        newNextStart: allProductsModel.data![0].nextStart,
        newIsLoadingPaging: false,
      ));
    }

    if(dataState is DataFailed){
      /// emit error
      emit(state.copyWith(
          newProductsDataStatus: ProductsDataError(dataState.error!),
          newIsLoadingPaging: false
      ));
    }
  }
}
