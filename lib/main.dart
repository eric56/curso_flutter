import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CreateFormTransfer(),
        drawer: DrawerByteBank(),
      ),
    );
  }
}

class CreateFormTransfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer Transfrência'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(labelText: 'Conta', hintText: '0000'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Valor',
                  hintText: '0.00'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: Text('Transferir'),
          ),
        ],
      ),
    );
  }
}

void callback() {}

class TransfersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferências')),
      body: Column(
        children: [
          TransferData(TransferDTO(560.76, '3567', '12289-0', 'Itaú')),
          TransferData(TransferDTO(1490.21, '4561', '11456-9', 'Santander')),
          TransferData(TransferDTO(90.00, '4561', '11456-9', 'Santander')),
          TransferData(TransferDTO(341.09, '3567', '12289-0', 'Itaú')),
          TransferData(TransferDTO(128.55, '3567', '12289-0', 'Itaú'))
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add)),
      drawer: DrawerByteBank(),
    );
  }
}

class TransferData extends StatelessWidget {
  final TransferDTO _transfer;

  const TransferData(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this._transfer._value.toString()),
        subtitle: Text(this._transfer.getDetailTransfer()),
        leading: Icon(Icons.monetization_on),
      ),
    );
  }
}

class TransferDTO {
  final double _value;
  final String _agency;
  final String _account;
  final String _bank;

  TransferDTO(this._value, this._agency, this._account, this._bank);

  String getDetailTransfer() {
    return _bank.toString() +
        ' - Agência: ' +
        this._agency +
        ' - Conta: ' +
        this._account;
  }
}

//Drawer App
class DrawerByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
