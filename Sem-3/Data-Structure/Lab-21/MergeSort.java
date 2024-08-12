import java.util.Scanner;

public class MergeSort {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int arr[] = new int[5];
        System.out.println("Enter five elements");
        for (int i = 0; i < 5; i++) {
            System.out.print("arr[" + i + "] : ");
            arr[i] = sc.nextInt();
        }
        System.out.print("Unsorted : ");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }

        MergeSort.divide(arr, 0, arr.length - 1);

        System.out.print("\nSorted : ");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        sc.close();
    }

    public static void divide(int[] arr, int si, int ei) {
        if (si >= ei) {
            return;
        }

        int mid = (si + ei) / 2;

        divide(arr, si, mid);
        divide(arr, mid + 1, ei);

        conquer(arr, si, mid, ei);
    }

    public static void conquer(int[] arr, int si, int mid, int ei) {
        int[] merged = new int[ei - si + 1];

        int ind1 = si;
        int ind2 = mid + 1;
        int i = 0;

        while (ind1 <= mid && ind2 <= ei) {
            if (arr[ind1] < arr[ind2]) {
                merged[i++] = arr[ind1++];
            } else {
                merged[i++] = arr[ind2++];
            }
        }
        while (ind1 <= mid) {
            merged[i++] = arr[ind1++];
        }
        while (ind2 <= ei) {
            merged[i++] = arr[ind2++];
        }

        System.arraycopy(merged, 0, arr, si, merged.length);
    }
}
