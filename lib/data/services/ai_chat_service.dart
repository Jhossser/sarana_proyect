import 'dart:math';

/// Service that simulates AI responses about Bolivian tourism and local businesses.
/// In production, this would call a real AI API (e.g., Gemini).
class AiChatService {
  static final _random = Random();

  // ── Welcome message ────────────────────────────────────────────────────
  static const String welcomeMessage =
      '¡Hola! Soy Sara, tu asistente de turismo comunitario en Bolivia 🦙\n\n'
      'Puedo ayudarte a descubrir:\n'
      '🍽️ Gastronomía boliviana auténtica\n'
      '🧶 Artesanías y mercados locales\n'
      '🏨 Hospedaje comunitario\n'
      '🗺️ Rutas culturales ancestrales\n\n'
      '¿Qué te gustaría explorar hoy?';

  // ── Categorized responses ──────────────────────────────────────────────
  static const List<String> _gastroResponses = [
    '🍽️ ¡Bolivia tiene una gastronomía increíble! Te recomiendo:\n\n'
        '• **Salteña paceña** — La mejor en el Mercado Rodríguez, Bs. 5 c/u\n'
        '• **Gustu Restaurant** — Alta cocina boliviana con ingredientes nativos\n'
        '• **Theobroma** — Chocolates artesanales con cacao de los Yungas\n\n'
        '¿Estás en La Paz, Cochabamba o Santa Cruz?',
    '🌶️ ¡Que rico! Aquí mis favoritos de la gastronomía boliviana:\n\n'
        '• **Fricasé** — Caldo de cerdo con chuño, el desayuno de campeones\n'
        '• **Sopa de Maní** — Espesa y nutritiva, típica de los valles\n'
        '• **Api con pastel** — Bebida caliente de maíz morado perfecta para el frío del altiplano\n\n'
        'El Mercado Rodríguez en La Paz es el lugar para probarlos todos 🥄',
    '☕ Bolivia produce uno de los mejores cafés del mundo. El café de los Yungas es Denominación de Origen Protegida.\n\n'
        '• **Café Yungas** — Producido a 1,500-2,000 msnm, aroma floral único\n'
        '• **Theobroma** en La Paz ofrece café de especialidad con cacao boliviano\n\n'
        'Un café boliviano es el mejor souvenir que te puedes llevar ☕🍫',
  ];

  static const List<String> _craftResponses = [
    '🧶 ¡Las artesanías bolivianas son patrimonio vivo! Mis recomendaciones:\n\n'
        '• **Taller Awayo** (La Paz) — Tejidos aymaras auténticos en telar a pedal\n'
        '• **Calle Sagárnaga** (La Paz) — La calle de las artesanías, Bs. 50 a 500\n'
        '• **Mercado Artesanal de Sucre** — Tejidos jalq\'a únicos en el mundo\n\n'
        '¡Cada pieza cuenta la historia de su comunidad! 🎨',
    '🎭 Las máscaras del Carnaval de Oruro son Patrimonio UNESCO. En **Artesanías Bolivia** de la Sagárnaga puedes encontrar:\n\n'
        '• Máscaras de diablada pintadas a mano (desde Bs. 350)\n'
        '• Trajes de ch\'uta y morenada\n'
        '• Miniaturas del carnaval\n\n'
        'El Carnaval de Oruro es en febrero, ¡el evento más impresionante de Bolivia! 🎪',
    '💍 La plata potosina es famosa desde el siglo XVI. En Potosí y La Paz puedes encontrar joyería artesanal en plata 925 con diseños precolombinos.\n\n'
        '• Pulseras con chakana (cruz andina)\n'
        '• Aretes con diseños de la Puerta del Sol de Tiwanaku\n'
        '• Anillos con turquesa y lapislázuli andino\n\n'
        '¡Un recuerdo único que dura para siempre! ✨',
  ];

  static const List<String> _lodgingResponses = [
    '🏨 Para dormir con encanto boliviano, te recomiendo:\n\n'
        '• **Hotel Rosario del Lago** (Copacabana) — Vista al Titicaca, Bs. 420/noche\n'
        '• **Hostal Kollasuyo** (Tiwanaku) — Construcción de adobe ancestral, Bs. 180\n'
        '• **Selina La Paz** — Moderno coliving con arte urbano boliviano\n\n'
        '¿Cuántas noches planeas quedarte y cuál es tu presupuesto? 🌙',
    '☀️ El lago Titicaca es una experiencia mágica. El **Hotel Rosario del Lago** en Copacabana tiene habitaciones con vista directa al lago más alto del mundo (3,812 msnm).\n\n'
        'Desde ahí puedes tomar botes a la Isla del Sol y la Isla de la Luna, lugares sagrados del Imperio Inca 🚣',
    '🏔️ Si vas al Salar de Uyuni, hay una experiencia única: **hoteles construidos con bloques de sal**. Las paredes, los muebles y el piso son de sal pura del salar.\n\n'
        '¡Es literalmente dormir dentro del salar! Una noche cuesta alrededor de Bs. 450 con cena incluida 🌟',
  ];

  static const List<String> _routeResponses = [
    '🗺️ Bolivia tiene algunas de las rutas más impresionantes de Sudamérica:\n\n'
        '• **Salar de Uyuni** — El espejo más grande del mundo en época de lluvias\n'
        '• **Tiwanaku** — Civilización de 3,500 años, Patrimonio UNESCO\n'
        '• **Camino del Inca** (Qhapaq Ñan) — Trek histórico hasta la Isla del Sol\n'
        '• **Valle de la Luna** — Paisaje lunar a 10 min de La Paz\n\n'
        '¿Cuánto tiempo tienes para explorar? 🦙',
    '🌅 El **Salar de Uyuni** en noviembre-marzo se convierte en un espejo gigante cuando llueve. Las fotos de reflejos son absolutamente surrealistas.\n\n'
        'La operadora **Salar de Uyuni Adventure** hace tours de 1 a 3 días desde Bs. 280 por persona, con guías de la comunidad quechua local 📸',
    '🏛️ **Tiwanaku** es el legado de la civilización más avanzada del altiplano sudamericano. La Puerta del Sol pesa 10 toneladas y fue tallada en un solo bloque de piedra.\n\n'
        'Los guías aymaras de **Tiwanaku Ancestral Tours** te explican el sitio desde la cosmovisión andina: fascinante y muy diferente a la visión arqueológica convencional 🌿',
  ];

  static const List<String> _generalResponses = [
    '🦙 ¡Bolivia es un destino increíble! Tiene 36 naciones indígenas, 3 zonas climáticas (altiplano, valles y trópico) y una diversidad cultural única en el mundo.\n\n'
        '¿Qué te interesa más: gastronomía 🍽️, artesanías 🧶, hospedaje 🏨 o rutas culturales 🗺️?',
    '🌟 Bolivia es el país con mayor diversidad cultural de Sudamérica. Aquí los datos curiosos:\n\n'
        '• 36 idiomas oficiales (junto al español)\n'
        '• La ciudad más alta del mundo: El Alto, 4,150 msnm\n'
        '• El salar más grande del planeta: Uyuni, 10,582 km²\n'
        '• La cascada de sal: Solo en Bolivia existe\n\n'
        '¿Sobre qué quieres saber más? 😊',
    '💡 Un consejo para tu visita a Bolivia:\n\n'
        '🏔️ Si vas al altiplano (La Paz, Uyuni), tómate 1-2 días para aclimatarte al soroche (mal de altura). Toma mate de coca, camina despacio y bebe mucha agua.\n\n'
        '¿Vienes pronto a Bolivia? Te puedo ayudar a planificar tu itinerario 🗺️',
    '🎵 La música boliviana es fascinante:\n\n'
        '• **Saya** — Ritmo afroboliviano de los Yungas\n'
        '• **Tinku** — Música guerrera del norte de Potosí\n'
        '• **Morenada** — Ritmo del Carnaval de Oruro\n'
        '• **Charango** — Instrumento de cuerdas hecho con caparazón de armadillo o madera\n\n'
        'En La Paz hay peñas folklóricas donde puedes vivir esto en vivo 🎸',
  ];

  /// Generates a simulated AI response based on the user's message.
  Future<String> generateResponse(String userMessage) async {
    // Simulate network latency
    await Future.delayed(Duration(milliseconds: 800 + _random.nextInt(700)));

    final lower = userMessage.toLowerCase();

    // Keyword-based routing
    if (_containsAny(lower, [
      'salteña', 'gastronomía', 'gastronomy', 'comida', 'comer', 'restaurante',
      'café', 'chocolate', 'yungas', 'fricasé', 'pique', 'silpancho', 'sopa',
      'desayuno', 'almuerzo', 'cena', 'mercado', 'gustu',
    ])) {
      return _gastroResponses[_random.nextInt(_gastroResponses.length)];
    }

    if (_containsAny(lower, [
      'artesanía', 'artesania', 'tejido', 'aguayo', 'awayo', 'máscara',
      'mascara', 'cerámica', 'ceramica', 'joyería', 'joyeria', 'plata',
      'charango', 'carnaval', 'sagárnaga', 'sagaranaga',
    ])) {
      return _craftResponses[_random.nextInt(_craftResponses.length)];
    }

    if (_containsAny(lower, [
      'hospedaje', 'hotel', 'hostal', 'dormir', 'alojamiento', 'noche',
      'habitación', 'habitacion', 'titicaca', 'copacabana',
    ])) {
      return _lodgingResponses[_random.nextInt(_lodgingResponses.length)];
    }

    if (_containsAny(lower, [
      'ruta', 'tour', 'viaje', 'salar', 'uyuni', 'tiwanaku', 'inca',
      'trekking', 'luna', 'chacaltaya', 'isla', 'cultural', 'patrimonio',
    ])) {
      return _routeResponses[_random.nextInt(_routeResponses.length)];
    }

    // Default general response
    return _generalResponses[_random.nextInt(_generalResponses.length)];
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }
}
