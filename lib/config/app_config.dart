class AppConfig {
  // Variável estática: acessível de qualquer lado sem precisar de instanciar
  static String baseUrl = '';

  // Método para inicializar (chamado no main)
  static void initialize({required String apiBaseUrl}) {
    baseUrl = apiBaseUrl;
  }
}
