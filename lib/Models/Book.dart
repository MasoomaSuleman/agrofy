class Book {
  String name;
  String buyPath;
  String url;
  Book({this.name, this.buyPath, this.url});
  static List<Book> books = [
    Book(
        name: 'GST Practice Manual',
        url: 'assets/images/practice.jpg',
        buyPath:
            'https://www.taxmann.com/bookstore/professional/gst-manual-with-practice-manual-2019.aspx'),
    Book(
        name: 'GST Audit & Annual Return',
        url: 'assets/images/audit.jpg',
        buyPath:
            'https://www.taxmann.com/bookstore/professional/gst-audit-and-annual-return-2019.aspx'),
    Book(
        name: 'GST Refunds',
        url: 'assets/images/refunds.jpg',
        buyPath:
            'ttps://www.taxmann.com/bookstore/professional/gst-refunds-2019.aspx'),
    Book(
        name: 'GST New Returns with e-Invoicing',
        url: 'assets/images/returns.jpg',
        buyPath:
            'https://www.taxmann.com/bookstore/professional/gst-new-returns-with-e-invoicing-2019.aspx'),
    Book(
        name: 'GST e-Invoicing',
        url: 'assets/images/invoicing.jpg',
        buyPath:
            'https://www.taxmann.com/bookstore/professional/gst-e-invoicing-2019.aspx'),
  ];
}

//List<Book> books = [
//  Book(name: 'GST Practice Manual'),
//  Book(name: 'GST Audit & Annual Return'),
//  Book(name: 'GST Refunds'),
//  Book(name: 'GST New Returns with e-Invoicing'),
//  Book(name: 'GST e-Invoicing'),
//];
