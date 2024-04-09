import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar()
    );
  }
}

AppBar appBar() {
    return AppBar(
      //definicao do titulo e estilizacao dele
      title: const Text( 
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      // definindo um detector de acoes ocorridas dentro da AppBar com suporte para adicao de metodos em cada interacao com um componente
      leading: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          // usando um asset que importamos para ser o icone dessa parte da appBar
          child: SvgPicture.asset( 
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
      // aqui as acoes sao definidas em formato de lista
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
      ],
    );
  }