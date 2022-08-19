import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class CategoriesByPersonPage extends StatefulWidget {
  final LearnController _learnController = Get.find();
  final ClassificationService _classificationService = Get.find();

  CategoriesByPersonPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesByPersonPage> createState() => _CategoriesBypersonPageState();
}

class _CategoriesBypersonPageState extends State<CategoriesByPersonPage> {
  final TreeController _controller = TreeController(allNodesExpanded: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frases com esta classificação'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: Colors.black12,
                child: const Text('Filtros e ações: '),
              ),
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: 'Classificações encontradas na NGB e outras',
                child: SizedBox(
                  // color: Colors.red,
                  width: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        'NGB',
                        style: TextStyle(
                            color: widget._classificationService.selectedNgb
                                ? Colors.green
                                : Colors.black),
                      ),
                      onTap: () {
                        widget._classificationService.categoryFilteredBy('ngb');
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Classificações mais comuns ao CC e outras',
                child: SizedBox(
                  // color: Colors.red,
                  width: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        'CC',
                        style: TextStyle(
                            color: widget._classificationService.selectedNgb
                                ? Colors.black
                                : Colors.green),
                      ),
                      onTap: () {
                        widget._classificationService.categoryFilteredBy('cc');
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Encolher toda a lista',
                child: SizedBox(
                  // color: Colors.red,
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.collapseAll();
                      });
                    },
                    icon: Icon(Icons.close_fullscreen_sharp,
                        size: 15,
                        color: _controller.allNodesExpanded
                            ? Colors.black
                            : Colors.green),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Expandir toda a lista',
                child: SizedBox(
                  // color: Colors.red,
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.expandAll();
                      });
                    },
                    icon: Icon(Icons.open_in_full,
                        size: 15,
                        color: !_controller.allNodesExpanded
                            ? Colors.black
                            : Colors.green),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(child: buildTree()))),
          ),
        ],
      ),
    );
  }

  Widget buildTree() {
    List<TreeNode> nodes = widget._learnController.createTree();

    return TreeView(
      treeController: _controller,
      nodes: nodes,
    );
  }
}
