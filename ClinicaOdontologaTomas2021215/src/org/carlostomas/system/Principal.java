/*
Nombre: Carlos Estuardo Tomas Mejia
Carnet:2021215
CodigoTecnico: IN5AV
Fecha Creacion:20/02/2022 
Fecha Modificacion:08/05/2022
 */
package org.carlostomas.system;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.carlostomas.controller.MenuPrincipalController;
import org.carlostomas.controller.PacienteController;
import org.carlostomas.controller.ProgramadorController;

/**
 *
 * @author LENOVO
 */
public class Principal extends Application {
    private Stage escenarioPrincipal;
    private Scene escena;
    private final String PAQUETE_VISTA = "/org/carlostomas/view/";
    
    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Clinica Odontologa");
        escenarioPrincipal.getIcons().add(new Image("/org/carlostomas/image/LogoClinica.png"));
//        Parent root = FXMLLoader.load(getClass().getResource("/org/carlostomas/view/MenuPrincipalView.fxml"));
//        Scene escena = new Scene(root);
//        escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
             
    }
    
    public void menuPrincipal(){
        try{
            MenuPrincipalController ventanaMenu = ( MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml",405,400);
            ventanaMenu.setEscenarioPrincipal(this);
        }catch(Exception e){
          e.printStackTrace();
        }
    }
    public void ventanaProgramador(){
        try{
            ProgramadorController vistaProgramador = (ProgramadorController)cambiarEscena("ProgramadorView.fxml",533,293);
            vistaProgramador.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPacientes(){
        try{
            PacienteController vistaPacientes = (PacienteController)cambiarEscena("PacientesView.fxml",1050,342);
            vistaPacientes.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
            
    
    

   
    public static void main(String[] args) {
        launch(args);
    }
    
    public Initializable cambiarEscena(String fxml, int ancho, int alto)throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        return resultado;
    }
}
