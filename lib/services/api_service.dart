class ApiService {
  static String url = 'https://ezys.in/customerApp/';
  static String uploads = "https://bechdo.co/api/uploads";

  static String getImageUrl(String imageName) {
    return 'https://bechdo.co/api/uploads/$imageName';
  }
}
