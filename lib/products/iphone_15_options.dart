import 'package:begining/screen/navigation.dart';
import 'package:flutter/material.dart';

class Iphone15Options extends StatelessWidget {
  const Iphone15Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: const AssetImage('assets/products/iphone_16.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '\$ 1,199',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                    child: Text(
                      'The most attractive installment plans',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: DataTable(
                              dataRowColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              columnSpacing: 12,
                              dataRowHeight: 40,
                              headingRowHeight: 40,
                              headingRowColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 164, 188, 244),
                              ),
                              columns: [
                                DataColumn(label: Text('Product Price')),
                                DataColumn(label: Text('\$ 1500')),
                              ],
                              rows: [
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Down payment'))),
                                    DataCell(Text('\$ 150')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Term'))),
                                    DataCell(Text('6 months')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Interest Rate'))),
                                    DataCell(Text('0 %')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Monthly Payment'))),
                                    DataCell(Text('\$ 230')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Difference'))),
                                    DataCell(Text('\$ 110')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Total Payment'))),
                                    DataCell(Text('\$ 1610')),
                                  ],
                                )
                            
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: DataTable(
                              dataRowColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              columnSpacing: 12,
                              dataRowHeight: 40,
                              headingRowHeight: 40,
                              headingRowColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 164, 188, 244),
                              ),
                              columns: [
                                DataColumn(label: Text('Product Price')),
                                DataColumn(label: Text('\$ 1500')),
                              ],
                              rows: [
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Down payment'))),
                                    DataCell(Text('\$ 150')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Term'))),
                                    DataCell(Text('6 months')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Interest Rate'))),
                                    DataCell(Text('0 %')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Monthly Payment'))),
                                    DataCell(Text('\$ 230')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Difference'))),
                                    DataCell(Text('\$ 110')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Total Payment'))),
                                    DataCell(Text('\$ 1610')),
                                  ],
                                )
                            
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: DataTable(
                              dataRowColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              columnSpacing: 12,
                              dataRowHeight: 40,
                              headingRowHeight: 40,
                              headingRowColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 164, 188, 244),
                              ),
                              columns: [
                                DataColumn(label: Text('Product Price')),
                                DataColumn(label: Text('\$ 1500')),
                              ],
                              rows: [
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Down payment'))),
                                    DataCell(Text('\$ 150')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Term'))),
                                    DataCell(Text('6 months')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Interest Rate'))),
                                    DataCell(Text('0 %')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Monthly Payment'))),
                                    DataCell(Text('\$ 230')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Difference'))),
                                    DataCell(Text('\$ 110')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text(('Total Payment'))),
                                    DataCell(Text('\$ 1610')),
                                  ],
                                )
                            
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}
