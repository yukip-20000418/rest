import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      title: 'REST-TEST',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _counterCtl;
  late TextEditingController _nameCtl;

  @override
  void initState() {
    super.initState();
    _counterCtl = TextEditingController(text: '100');
    _nameCtl = TextEditingController(text: 'no-name');
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _counterCtl.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counterCtl.text = (int.parse(_counterCtl.text) + 1).toString();
    });
    debugPrint('count-up:${_counterCtl.text}');
  }

  void _create() {
    debugPrint(
      'create:${_nameCtl.text},counter:${_counterCtl.text}, date:${DateTime.now()}',
    );
  }

  void _update(id) {
    debugPrint('update:${_counterCtl.text},  id:$id');
  }

  void _delete(id) {
    debugPrint('delete: id:$id');
  }

  Widget list() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      children:
          [
            Column(
              children: [
                const SizedBox(height: 1),
                Container(
                  color: const Color.fromRGBO(100, 100, 200, 0.1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(flex: 3, child: Text('text 1')),
                                Expanded(flex: 3, child: Text('text 2')),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              color: const Color.fromRGBO(128, 128, 200, 0.1),
                              child: Text('text 3'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 1),
                      IconButton(
                        onPressed: () => _update(3),
                        icon: const Icon(Icons.update),
                      ),
                      IconButton(
                        onPressed: () => _delete(4),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ].toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var wrapA = Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'name',
              prefixIcon: Icon(Icons.face),
            ),
            controller: _nameCtl,
          ),
        ),
        SizedBox(
          width: 200,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'counter',
              prefixIcon: Icon(Icons.pin),
            ),
            controller: _counterCtl,
          ),
        ),
      ],
    );

    var wrapB = Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runAlignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        ElevatedButton.icon(
          onPressed: _create,
          icon: const Icon(Icons.create_outlined),
          label: const Text('create'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('REST ACCESS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20.0,
              runSpacing: 20.0,
              children: [wrapA, wrapB],
            ),
            const SizedBox(height: 20),
            Expanded(child: list()),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
