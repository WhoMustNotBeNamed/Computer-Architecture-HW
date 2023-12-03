#include <iostream>
#include <iomanip>
#include <limits>
#include <ctime>
#include <pthread.h>

struct Package {
    double* arrayA;  // Указатель на начало области обработки A
    double* arrayB;  // Указатель на начало области обработки B
    int threadNum;   // Номер потока
    double sum;      // Формируемая частичная сумма
} ;

const unsigned int arrSize = 10000000;
//const unsigned int arrSize = 100000000;
//const unsigned int arrSize = 500000000;
//const unsigned int arrSize = 100000000000;

double *A ;  //последовательность чисел a0...
double *B ;  //последовательность чисел b0...

const int threadNumber = 1;       // Количество потоков
//const int threadNumber = 2;     // Количество потоков
//const int threadNumber = 4;     // Количество потоков
//const int threadNumber = 8;     // Количество потоков
//const int threadNumber = 1000;  // Количество потоков

// Cтартовая функция для дочерних потоков
void *func(void *param) {    //вычисление суммы A[i]*B[i] в потоке
    // Востановление структуры
    Package* p = (Package*)param;
    p->sum = 0.0;
    for(unsigned int i = p->threadNum ; i < arrSize - 1; i+=threadNumber) {
        p->sum += p->arrayA[i] * p->arrayB[i]; // A[i]*B[i]
    }
    return nullptr;
}

int main() {
    double rez = 0.0 ; // Для записи окончательного результата

    // заполнение массива A
    A = new double[arrSize];
    if(A == nullptr) {
        std::cout << "Incorrect size of vector = A " << arrSize << "\n";
        return 1;
    }
    for(int i = 0; i < arrSize; ++i) {
        A[i] = double(i + 1);
    }

    // заполнение массива B
    B = new double[arrSize];
    if(B == nullptr) {
        std::cout << "Incorrect size of vector B = " << arrSize << "\n";
        return 1;
    }
    for(int i = 0; i < arrSize; ++i) {
        B[i] = double(arrSize - i);
    }

    pthread_t thread[threadNumber];
    Package pack[threadNumber];

    clock_t start_time =  clock(); // начальное время

    //создание дочерних потоков
    for (int i=0 ; i<threadNumber ; i++) {
        // Формирование структуры для передачи потоку
        pack[i].arrayA = A;
        pack[i].arrayB = B; // добавляем B

        pack[i].threadNum = i;
        pthread_create(&thread[i], nullptr, func, (void*)&pack[i]) ;
    }

    clock_t thread_started_time = clock(); // конечное время

    for (int i = 0 ; i < threadNumber; i++) {    // ожидание завершения работы дочерних потоков
        pthread_join(thread[i], nullptr) ;       // и получение результата их вычислений
        rez += pack[i].sum;
    }

    clock_t end_time = clock(); // конечное время

    //вывод результата
    std::cout << "Sum of A*B = " << std::scientific <<
        std::setprecision(std::numeric_limits<double>::digits10 + 1) << rez << "\n" ;

    std::cout << "Streams have started = " << thread_started_time - start_time << "\n";
    std::cout << "Billing and assembly time = " << end_time - start_time << "\n";

    delete[] A;
    delete[] B;
    return 0;
}
