#include <stdio.h>
int main() {

    int binarySearch(int arr[], int from, int to, int key) {
        if (from < to) {
            int mid = (from / 2) + (to / 2);
            if (arr[mid] == key) {
                return mid;
            } else if (key < arr[mid]) {
                return binarySearch(arr, from, mid - 1, key);
            } else if (key > arr[mid]) {
                return binarySearch(arr, mid+1, to, key);
            }
        }
        return -1;
    }
    int xs[] = {1,2,3,4};
    printf("%d\n", binarySearch(xs, 0, 3, 2));
}
