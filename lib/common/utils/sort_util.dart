
import 'package:travelgrid/common/utils/date_time_util.dart';

class SortUtil{


     sort(int id,list) {

      switch(id) {
        case 1:

          list.sort((a, b) {
            print(" list.sort((a, b)");
            int a1= (b.totalAmount).round();
            int a2= (a.totalAmount).round();

            return a1.compareTo(a2);
          });
          return list;
        case 2:
          list.sort((a, b) {
            int a1= (a.totalAmount).round();
            int a2= (b.totalAmount).round();

            return a1.compareTo(a2);
          });
          return list;

        case 3:
          list.sort((a, b) {
            String date1 ="";
            String date2 ="";


            if(a.startDate!=null){
              date1 = MetaDateTime().getDate(a.startDate.toString(), format: "yyyy-MM-dd");
              date2 = MetaDateTime().getDate(b.startDate.toString(), format: "yyyy-MM-dd");
            }else{
              date1 = MetaDateTime().getDate(a.date.toString(), format: "yyyy-MM-dd");
              date2 = MetaDateTime().getDate(b.date.toString(), format: "yyyy-MM-dd");
            }


            return DateTime.parse(date1).compareTo(DateTime.parse(date2));
          });
          return list;
        case 4:
          list.sort((a, b) {
            String date1 ="";
            String date2 ="";


            if(a.startDate!=null){
              date1 = MetaDateTime().getDate(a.startDate.toString(), format: "yyyy-MM-dd");
              date2 = MetaDateTime().getDate(b.startDate.toString(), format: "yyyy-MM-dd");
            }else{
              date1 = MetaDateTime().getDate(a.date.toString(), format: "yyyy-MM-dd");
              date2 = MetaDateTime().getDate(b.date.toString(), format: "yyyy-MM-dd");
            }

            return DateTime.parse(date2).compareTo(DateTime.parse(date1));
          });
          return list;

     }
    }
}