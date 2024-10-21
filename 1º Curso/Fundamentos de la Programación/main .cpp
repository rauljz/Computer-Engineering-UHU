//RAÚL JIMÉNEZ SUÁREZ--49235802R

#include <iostream>
#include <string.h>

using namespace std;

struct Jugador{
    int id;
    char nombre[10];
    int puntos;
};

class Competicion{
    int num_jugadores;
    Jugador lista_jugadores[5];
    int id_finalistas[3];
    void mostrarDatosJugador(Jugador jugador);
public:
    Competicion();
    int registrarJugador(char nombre[10]);
    void evaluarJugadores();
    int obtenerFinalistas();
    void mostrarListaJugadores();
    void mostrarFinalistas();
};

Competicion::Competicion()
{
    num_jugadores=0;
}

int Competicion::registrarJugador(char nombre[10])
{
    if(num_jugadores<5){
        strcpy(lista_jugadores[num_jugadores].nombre,nombre);
        lista_jugadores[num_jugadores].id=num_jugadores+1;
        lista_jugadores[num_jugadores].puntos=0;
        num_jugadores++;
        return 0;
    }else
        return -1;
}

void Competicion::evaluarJugadores()
{
    for(int i=0;i<num_jugadores;i++){
        lista_jugadores[i].puntos=rand()%96+5;
    }
}

int Competicion::obtenerFinalistas()
{
    int n=0;
    int cont1=0;
    int cont2=0;
    int cont3=0;
    int indice;

    if(num_jugadores>3){
        for(int i=0;i<num_jugadores;i++){
            if(lista_jugadores[i].puntos>0){
                n++;
            }
        }
        if(n==num_jugadores){
            for(int j=0;j<num_jugadores;j++){
                if(lista_jugadores[j].puntos>cont1){
                    cont1=lista_jugadores[j].puntos;
                    indice=j;
                }
            }
            id_finalistas[0]=lista_jugadores[indice].id;

            for(int j=0;j<num_jugadores;j++){
                if(lista_jugadores[j].puntos>cont2 && lista_jugadores[j].puntos<cont1){
                    cont2=lista_jugadores[j].puntos;
                    indice=j;
                }
            }
            id_finalistas[1]=lista_jugadores[indice].id;

            for(int j=0;j<num_jugadores;j++){
                if(lista_jugadores[j].puntos>cont3 && lista_jugadores[j].puntos<cont1 && lista_jugadores[j].puntos<cont2){
                    cont3=lista_jugadores[j].puntos;
                    indice=j;
                }
            }
            id_finalistas[2]=lista_jugadores[indice].id;
            return 0;
        }else
            return -2;
    }else
        return -1;
}

void Competicion::mostrarDatosJugador(Jugador jugador)
{
    cout<<"Nombre: "<<jugador.nombre<<endl;
    cout<<"Id: "<<jugador.id<<endl;
    cout<<"Puntos: "<<jugador.puntos<<endl<<endl;
}

void Competicion::mostrarListaJugadores()
{
    if(num_jugadores>0){
        for(int i=0;i<num_jugadores;i++){
            mostrarDatosJugador(lista_jugadores[i]);
        }
    }else
        cout<<"No hay jugadores registrados."<<endl;
}

void Competicion::mostrarFinalistas()
{
    for(int i=0;i<num_jugadores;i++){
        if(lista_jugadores[i].id==id_finalistas[0] || lista_jugadores[i].id==id_finalistas[1] || lista_jugadores[i].id==id_finalistas[2]){
            mostrarDatosJugador(lista_jugadores[i]);
        }
    }
}

int main()
{
    Competicion c;
    int opc;
    char nombre[10];

    do{
        cout<<"\t\t\t MENU"<<endl;
        cout<<"1. Registrar jugador"<<endl;
        cout<<"2. Mostrar lista jugadores"<<endl;
        cout<<"3. Evaluar jugadores y obtener finalistas"<<endl;
        cout<<"4. Mostrar lista finalistas"<<endl;
        cout<<"5. Salir"<<endl;
        cin>>opc;

        switch(opc){
        case 1:
            system("cls");
            cout<<"Introduce el nombre del jugador: ";
            cin>>nombre;
            if(c.registrarJugador(nombre)==0){
                cout<<"Registrado correctamente"<<endl;
            }else
                cout<<"Error, la lista de jugadores esta completa."<<endl;

            system("pause");
            system("cls");
            break;
        case 2:
            system("cls");
            c.mostrarListaJugadores();
            system("pause");
            system("cls");
            break;
        case 3:
            system("cls");

            c.evaluarJugadores();
            if(c.obtenerFinalistas()>-1){
                if(c.obtenerFinalistas()>-2){
                    cout<<"Finalistas obtenidos correctamente."<<endl;
                }else
                    cout<<"Error, aun no han sido evaluados."<<endl;
            }else
                cout<<"Error, hay menos de 3 jugadores."<<endl;

            system("pause");
            system("cls");
            break;
        case 4:
            system("cls");
            c.mostrarFinalistas();
            system("pause");
            system("cls");
            break;
        case 5:
            exit(0);
            break;
        default:
            cout<<"Opción incorrecta."<<endl;
            break;
        }

    }while(opc);

    return 0;
}
