// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, unused_field, prefer_final_fields, must_be_immutable, avoid_returning_null_for_void, prefer_is_empty
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_tcc_teste_sacolejando/src/models/evaluation_model.dart';
import 'package:projeto_tcc_teste_sacolejando/src/models/food_model.dart';
import 'package:projeto_tcc_teste_sacolejando/src/models/order_model.dart';
import 'package:projeto_tcc_teste_sacolejando/src/repositories/food/card_food.dart';
import 'package:projeto_tcc_teste_sacolejando/src/widgets/bottom_navigator_user.dart';

class OrderDetailScreen extends StatelessWidget {
  Order _order = Order(
    id: 1,
    userId: 1,
    foodId: 1,
    stPaymentId: 1,
    stOrderId: 1,
    orderPrice: '599,90',
    orderComment: 'Gostosão',
    orderDate: '02/11/2022',
    foods: [
      Food(
          id: 1,
          categoryId: 1,
          restaurantId: 1,
          foodName: 'X salada',
          foodPrice: '14,99',
          foodIngredients: 'Pão, queijo, presunto, salada e hamburguer')
    ],
    evaluations: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 180, 0, 0),
      ),
      body: SingleChildScrollView(
        child: _buildOrderDetails(context),
      ),
      bottomNavigationBar: BottomNavigatorUser(2),
    );
  }

  Widget _buildOrderDetails(context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _makeTextOrder('Numero do Pedido', _order.id.toString()),
          _makeTextOrder('Data', _order.orderDate),
          _makeTextOrder('Preço', _order.orderPrice),
          _makeTextOrder('Status do Pagamento', _order.stPaymentId.toString()),
          _makeTextOrder('Status do Pedido', _order.stOrderId.toString()),
          _makeTextOrder('Comentário', _order.orderComment),
          Container(
            height: 30,
          ),
          const Text(
            'Comidas:',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          _buildFoodsOrder(),
          Container(
            height: 30,
          ),
          const Text(
            'Avaliações:',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          _buildEvaluationsOrder(context),
        ],
      ),
    );
  }

  Widget _makeTextOrder(String textLabel, String textValue) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: <Widget>[
          Text(
            '$textLabel: ',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            textValue,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodsOrder() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _order.foods.length,
      itemBuilder: (context, index) {
        final Food food = _order.foods[index];
        return FoodCard(
          food: food,
          notShowIconCart: true,
        );
      },
    );
  }

  Widget _buildEvaluationsOrder(context) {
    if (_order.evaluations.length > 0) {
      return Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _order.evaluations.length,
          itemBuilder: (context, index) {
            final Evaluation evaluation = _order.evaluations[index];
            return _buildEvaluationsItens(evaluation, context);
          },
        ),
      );
    } else {
      return Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/order_evaluation');
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          child: const Text(
            "Avalie seu Pedido",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildEvaluationsItens(Evaluation evaluation, context) {
    return Card(
      elevation: 2.5,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey.shade100),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RatingBar.builder(
              initialRating: evaluation.stars,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 15,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) => null,
            ),
            Row(
              children: <Widget>[
                Text(
                  "${evaluation.userId} - ",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
