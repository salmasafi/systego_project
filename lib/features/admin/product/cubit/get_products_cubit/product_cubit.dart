// cubit/product_cubit.dart
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systego/core/services/endpoints.dart';
import 'package:systego/features/admin/product/models/warehouse_product.dart';
import '../../../../../core/services/dio_helper.dart';
import '../../../../../core/utils/error_handler.dart';
import '../../models/product_model.dart';
import 'product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);

  Future<void> getWareHouseProducts(String wareHouseID) async {
    emit(ProductsLoading());

    try {
      log('Starting products request...');

      final response = await DioHelper.getData(
        url: EndPoint.getWareHouseProducts(wareHouseID),
      );

      log('Response received: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;
        log('data received: ${response.data}');
        if (data['success'] == true && data['data'] != null) {
          final productsJson =
              data['data']['productWarehouses'] as List<dynamic>? ?? [];
          final warehouseProducts = productsJson
              .map(
                (json) =>
                    WarehouseProduct.fromJson(json as Map<String, dynamic>),
              )
              .toList()
              .reversed
              .toList();
          // Map to Product objects for the state (assuming partial mapping; adjust as needed based on full Product requirements)
          final products = warehouseProducts.where((wp) => wp.productId != null).map((
            wp,
          ) {
            // Construct a partial JSON for Product.fromJson, filling defaults for missing fields
            // This assumes Product.fromJson can handle minimal fields; expand defaults as per Product model
            final productJson = {
              '_id': wp.productId!.id,
              'name': wp.productId!.name,
              'quantity': wp.quantity,
              'description': '', // Default
              'price': 0.0, // Default
              'prices': [], // Default
              'categoryId': [], // Default
              'brandId': {
                '_id': '',
              }, // Default, assuming brandId is a map with id
              // Add more defaults for other required Product fields if necessary
            };
            return Product.fromJson(productJson);
          }).toList();
          log('Products fetch successful');
          log('Products ${products}');
          log('Products ${products.map((p) => p.toJson())}');

          emit(ProductsSuccess(products));
        } else {
          final errorMessage = data['message'] ?? 'Failed to fetch products';
          log('Products fetch failed: $errorMessage');
          emit(ProductsError(errorMessage));
        }
      } else {
        final errorMessage = ErrorHandler.handleError(response);
        log('Response error: $errorMessage');
        emit(ProductsError(errorMessage));
      }
    } catch (error) {
      log('Products fetch error caught: $error');
      final errorMessage = ErrorHandler.handleError(error);
      emit(ProductsError(errorMessage));
    }
  }
}
