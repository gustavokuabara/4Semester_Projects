#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_SELVAGENS 5
#define MAX_PORCOES 10

sem_t exclusaoMutua, vazio, cheio;
int porcoesMissionario = 0;

void *selvagem(void *arg) {
    int id = *((int *)arg);
    int comeu = 0;
    while (comeu < id + 3) {
        //Evita deadlock, faz o processo esperar para acessar o caldeirão
        sem_wait(&exclusaoMutua);
        
        //Acordar o Cozinheiro
        if (porcoesMissionario == 0) {
            sem_post(&vazio);
            sem_wait(&cheio);
        }
        
        comeu++;
        printf("[Selvagem %d]: Comendo\n", id);
        porcoesMissionario--;
        
        //Libera o caldeirão
        sem_post(&exclusaoMutua);
        sleep(1);
    }
    return NULL;
}

void *cozinheiro(void *arg) {
    int porcoesPreparadas = 0;
    int totalPorcoes = 0;
    
    //Contador para a quantidade de porcoes necessarias
    for(int i  = 1; i <= NUM_SELVAGENS; i++){
        totalPorcoes += i + 3;
    }
    
    while (1) {
        //Espera enquanto o caldeirão não está vazio
        sem_wait(&vazio);
        printf("\n[Cozinheiro]: Cozinhando!\n");
        porcoesPreparadas += MAX_PORCOES; 
        porcoesMissionario = MAX_PORCOES;
        //Confere quando o cozinheiro deve parar de executar
        if (porcoesPreparadas >= totalPorcoes) {
            sem_post(&cheio);
            break;
        }
        sem_post(&cheio);
    }
    return NULL;
}

int main() {
    //Threads dos Selvagens
    pthread_t selvagensThread[NUM_SELVAGENS];
    //Threads do Cozinheiro
    pthread_t cozinheiroThread;
    //Ids dos selvagens
    int selvagensIDs[NUM_SELVAGENS];

    sem_init(&exclusaoMutua, 0, 1);
    sem_init(&vazio, 0, 0);
    sem_init(&cheio, 0, 0);

    //Cria a Thread do Cozinheiro
    pthread_create(&cozinheiroThread, NULL, cozinheiro, NULL);
    
    //Cria a Thread de cada Selvagem
    for (int i = 0; i < NUM_SELVAGENS; i++) {
        selvagensIDs[i] = i + 1;
        pthread_create(&selvagensThread[i], NULL, selvagem, &selvagensIDs[i]);
    }

    for (int i = 0; i < NUM_SELVAGENS; i++) {
        pthread_join(selvagensThread[i], NULL);
    }

    pthread_join(cozinheiroThread, NULL);

    printf("\nTodos os Selvagens foram devidamente alimentados!");
    //Libera os semaforos
    sem_destroy(&exclusaoMutua);
    sem_destroy(&vazio);
    sem_destroy(&cheio);

    return 0;
}