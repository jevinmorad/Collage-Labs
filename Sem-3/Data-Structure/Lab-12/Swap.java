/* Compile :javac -d out -sourcepath . Lab_10\MyLinkedList.java Lab-12\Swap.java
Run: java -cp out Swap             
 */
import java.util.Scanner;

public class Swap {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        MyLinkedList<Integer> list = new MyLinkedList<>();
        
        System.out.println("Enter elements into list.");
        System.out.print("Enter number of elements you want to enter : ");
        int n = sc.nextInt();
        for (int i = 0; i < n; i++) {
            System.out.print("Enter element "+(i+1)+" : ");
            list.insertLast(sc.nextInt());
        }

        System.out.print("\nEnter k : ");
        int k = sc.nextInt();
        if (k>n && k<1) {
            System.out.println("Node not found");
            System.exit(0);
        }

        System.out.println("Before : ");
        list.print();

        list.swap(k);

        System.out.println("Before : ");
        list.print();
        
        sc.close();
    }
}
