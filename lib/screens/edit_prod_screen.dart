import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProdScreen extends StatefulWidget {
  static const route = '/edit_screen';
  @override
  _EditProdScreenState createState() => _EditProdScreenState();
}

class _EditProdScreenState extends State<EditProdScreen> {
  final _priceNode = FocusNode();
  final _descNode = FocusNode();
  final _urlController = TextEditingController();
  final _imageUrlNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(description: '', id: null, imageUrl: '', price: 0, title: '');
  var initValue = {'title': '', 'description': '', 'price': '', 'imageUrl': ''};

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImage);
    print('init');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('didCHange');
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      //this means we came to this screen through edit product
      _editedProduct = Provider.of<Products>(context).findProdById(id);
      initValue = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
      };
      _urlController.text = _editedProduct.imageUrl;
    }
  }

  @override
  void dispose() {
    _imageUrlNode.removeListener(_updateImage);
    _priceNode.dispose();
    _descNode.dispose();
    _urlController.dispose();
    _imageUrlNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrlNode.hasFocus) {
      if (!_urlController.text.startsWith('http') &&
          !_urlController.text.startsWith('https')) return;
      setState(() {});
    }
  }

  void _saveForm() {
    final valid = _form.currentState.validate();
    if (!valid) return;
    _form.currentState.save();
    if (_editedProduct.id == null) {
      print('Added');
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      print('updated');
      Provider.of<Products>(context,listen: false).updateProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product details'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Title'),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceNode),
                onSaved: (value) {
                  _editedProduct = Product(
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: value,
                      isFavorite: _editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please provide a title!';
                  else
                    return null;
                },
                initialValue: initValue['title'],
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Price'),
                focusNode: _priceNode,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descNode),
                onSaved: (value) {
                  _editedProduct = Product(
                      description: _editedProduct.description,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(value),
                      title: _editedProduct.title,
                      isFavorite: _editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a price!';
                  if (double.tryParse(value) == null)
                    return 'Please provide valid price!';
                  if (double.parse(value) <= 0)
                    return 'Please enter price greater than zero!';
                  return null;
                },
                initialValue: initValue['price'],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descNode,
                onSaved: (value) {
                  _editedProduct = Product(
                      description: value,
                      id: _editedProduct.id,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: _editedProduct.title,
                      isFavorite: _editedProduct.isFavorite);
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please provide a description!';
                  if (value.length < 10)
                    return 'Please provide description of atleast 10 characters';
                  return null;
                },
                initialValue: initValue['description'],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 5),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: FittedBox(
                      child: _urlController.text.isEmpty
                          ? Text(
                              'Enter a url!',
                              style: TextStyle(color: Colors.grey, fontSize: 5),
                            )
                          : Image.network(
                              _urlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _urlController,
                      focusNode: _imageUrlNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            description: _editedProduct.description,
                            id: _editedProduct.id,
                            imageUrl: value,
                            price: _editedProduct.price,
                            title: _editedProduct.title,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please provide an image URL!';
                        if (!value.startsWith('http') &&
                            !value.startsWith('https'))
                          return 'Please provide valid image URL';
                        return null;
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
