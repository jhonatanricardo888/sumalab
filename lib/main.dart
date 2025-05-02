import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicación de Múltiples Pantallas',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPrincipal(),
        '/perfil': (context) => const PerfilUsuario(),
        '/menu': (context) => const MenuRestaurante(),
        '/inicio': (context) => const InicioSesion(),
        '/galeria': (context) => const GaleriaProductos(),
        '/noticias': (context) => const NoticiasHomePage(),
      },
    );
  }
}

// Pantalla de Perfil de Usuario
class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Acción de edición
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://i.pinimg.com/736x/34/a2/b4/34a2b4266a9e1c1b09a842e24508eba8.jpg'),
          ),
          const SizedBox(height: 20),
          const Text('Jhonatan Ricardo Mamani Alejo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('Desarrollador de software', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/733/733547.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/733/733579.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/733/733585.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Pantalla de Menú de Restaurante
class MenuRestaurante extends StatefulWidget {
  const MenuRestaurante({super.key});

  @override
  State<MenuRestaurante> createState() => _MenuRestauranteState();
}

class _MenuRestauranteState extends State<MenuRestaurante> {
  String categoriaSeleccionada = 'Entradas';

 final Map<String, List<Map<String, dynamic>>> menu = {
  'Entradas': [
    {'nombre': 'Bruschetta', 'precio': 50, 'imagen': 'https://i.pinimg.com/736x/6a/03/7e/6a037e94167e3a70304a9ecd01014d7d.jpg'},
    {'nombre': 'Ensalada Rusa', 'precio': 60, 'imagen': 'https://i.pinimg.com/736x/03/fa/01/03fa0192d677340522d0312dc2db08e0.jpg'},
  ],
    'Sopas': [
      {'nombre': 'Sopa de Tomate', 'precio': 40, 'imagen': 'https://i.pinimg.com/736x/f7/78/69/f77869635e7f7abb8c29175fad58d5d4.jpg'},
      {'nombre': 'Crema de Champiñones', 'precio': 45, 'imagen': 'https://i.pinimg.com/736x/ac/6f/a2/ac6fa242cb4f88eca9f475f0e5e77e0b.jpg'},
    ],
    'Platos Principales': [
      {'nombre': 'Filete Mignon', 'precio': 150, 'imagen': 'https://i.pinimg.com/736x/20/7a/f8/207af8fd87ef9562c3663336be03896a.jpg'},
      {'nombre': 'Pasta Alfredo', 'precio': 120, 'imagen': 'https://i.pinimg.com/736x/90/46/ae/9046ae6e11bc5f8c67cd5ae9fd210315.jpg'},
    ],
    'Postres': [
      {'nombre': 'Tiramisú', 'precio': 70, 'imagen': 'https://i.pinimg.com/736x/95/ac/99/95ac9915404862eaa194c4b62c71d6b3.jpg'},
      {'nombre': 'Helado', 'precio': 50, 'imagen': 'https://i.pinimg.com/736x/dd/c7/31/ddc73191d4dce682a45f67e353b809fc.jpg'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final platos = menu[categoriaSeleccionada] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Menú: $categoriaSeleccionada')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.orange),
              child: const Center(child: Text('Categorías', style: TextStyle(color: Colors.white, fontSize: 24))),
            ),
            ...menu.keys.map((categoria) => ListTile(
              title: Text(categoria),
              onTap: () {
                setState(() {
                  categoriaSeleccionada = categoria;
                });
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: platos.length,
        itemBuilder: (context, index) {
          final plato = platos[index];
          return Card(
            margin: const EdgeInsets.all(50),
            child: ListTile(
              leading: Image.network(
                plato['imagen'],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
              ),
              title: Text(plato['nombre']),
              subtitle: Text('\$${plato['precio']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_border),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla de Inicio de Sesión
class InicioSesion extends StatelessWidget {
  const InicioSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text('Iniciar Sesión', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),
                const TextField(decoration: InputDecoration(labelText: 'Email')),
                const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Contraseña')),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, child: const Text('Iniciar sesión')),
                const SizedBox(height: 10),
                TextButton(onPressed: () {}, child: const Text('¿Olvidaste tu contraseña?')),
                TextButton(onPressed: () {}, child: const Text('Regístrate')),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: const Icon(Icons.account_circle, size: 100, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

// Galería de Productos
class GaleriaProductos extends StatelessWidget {
  const GaleriaProductos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> productos = [
      {
        'nombre': 'audifonos',
        'precio': '\$80',
        'imagen': 'https://i.pinimg.com/736x/4f/ed/5c/4fed5c5a36771b6212cf4a2f4527912e.jpg',
      },
      {
        'nombre': 'teclado rgb',
        'precio': '\$90',
        'imagen': 'https://i.pinimg.com/736x/16/1b/a7/161ba756c0f45c1029b96a3c0a5b1975.jpg',
      },
      {
        'nombre': 'mouse iinalambrico',
        'precio': '\$170',
        'imagen': 'https://i.pinimg.com/736x/26/e6/82/26e682f37b53a1c4bab0bb31a38036c8.jpg',
      },
      {
        'nombre': 'Teclado inalambrico',
        'precio': '\$60',
        'imagen': 'https://i.pinimg.com/736x/0e/ca/21/0eca21472a25c09c7eb0612a71f450b1.jpg',
      },
      {
        'nombre': 'audifono inalambrico',
        'precio': '\$120',
        'imagen': 'https://i.pinimg.com/736x/bd/e2/0e/bde20e7bfcf9bb2fd6539c0530155cd8.jpg',
      },
      {
        'nombre': 'Parlante rgb',
        'precio': '\$100',
        'imagen': 'https://i.pinimg.com/736x/1a/7c/dd/1a7cdd7900c8dcc8f8aef9290ae91c2f.jpg',
      },
      {
        'nombre': 'monitor 144hz',
        'precio': '\$85',
        'imagen': 'https://i.pinimg.com/736x/fa/6f/3b/fa6f3b83a9899e6cfa30b647d19de654.jpg',
      },
      {
        'nombre': 'Smart tv',
        'precio': '\$45',
        'imagen': 'https://i.pinimg.com/736x/a6/bd/61/a6bd61ebc075d65187bb53919090e9fd.jpg',
      },
      {
        'nombre': 'smart watch',
        'precio': '\$50',
        'imagen': 'https://i.pinimg.com/736x/1b/88/0c/1b880c8fb8fa8a61077f749ddabadb9a.jpg',
      },
      {
        'nombre': 'Tablet',
        'precio': '\$30',
        'imagen': 'https://i.pinimg.com/736x/87/ce/2d/87ce2dff8fd653f70fcd06c1d18e964c.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galería de Productos')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${producto['nombre']} seleccionado')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    producto['imagen']!,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, color: Colors.red);
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(producto['nombre']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(producto['precio']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla de Detalles de la Noticia
class NoticiaDetailPage extends StatelessWidget {
  final String titulo;

  const NoticiaDetailPage({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              'https://i.pinimg.com/736x/f1/54/4b/f1544b702aa3d25181e429bf12b1b20d.jpg',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
            const SizedBox(height: 20),
            const Text('Detalles completos de la noticia mostrados aquí.', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// Pantalla Principal de Noticias
class NoticiasHomePage extends StatelessWidget {
  const NoticiasHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> noticias = [
      {
        'titulo': 'Sequia en Bolivia',
        'resumen': 'El gobierno se reúne con la mesa de enlace para analizar la sequía.',
        'imagen': 'https://i.pinimg.com/736x/a2/98/2a/a2982ac7a094c51f800222bf8b36411d.jpg',
      },
      {
        'titulo': 'Innovación en Inteligencia Artificial',
        'resumen': 'Las últimas innovaciones en IA están transformando industrias clave.',
        'imagen': 'https://i.pinimg.com/736x/28/01/36/280136a913ee1713f0429182e78a2413.jpg',
      },
      {
        'titulo': 'Cambio Climático y Sus Efectos',
        'resumen': 'Expertos advierten sobre los impactos acelerados del cambio climático.',
        'imagen': 'https://i.pinimg.com/736x/7e/8d/52/7e8d52d6bd774597394338502d54449e.jpg',
      },
      {
        'titulo': 'Exploración Espacial: Misión a Marte',
        'resumen': 'Los astronautas se preparan para el próximo gran paso hacia la exploración de Marte.',
        'imagen': 'https://i.pinimg.com/736x/06/5f/09/065f09a9747ccefb73c2976345f3326f.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Noticias')),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          final noticia = noticias[index];
          return ListTile(
            leading: Image.network(
              noticia['imagen']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
            title: Text(noticia['titulo']!),
            subtitle: Text(noticia['resumen']!),
            onTap: () {
              // Usamos Navigator.push para ir a la página de detalle pasando el título como argumento
              Navigator.pushNamed(
                context,
                '/noticiaDetail', // Rutas nombradas
                arguments: noticia['titulo'],
              );
            },
          );
        },
      ),
    );
  }
}


// Menú Principal
class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Perfil de Usuario'),
              onTap: () => Navigator.pushNamed(context, '/perfil'),
            ),
            ListTile(
              title: const Text('Menú de Restaurante'),
              onTap: () => Navigator.pushNamed(context, '/menu'),
            ),
            ListTile(
              title: const Text('Inicio de Sesión'),
              onTap: () => Navigator.pushNamed(context, '/inicio'),
            ),
            ListTile(
              title: const Text('Galería de Productos'),
              onTap: () => Navigator.pushNamed(context, '/galeria'),
            ),
            ListTile(
              title: const Text('Noticias'),
              onTap: () => Navigator.pushNamed(context, '/noticias'),
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Bienvenido al menú principal')),
    );
  }
}

