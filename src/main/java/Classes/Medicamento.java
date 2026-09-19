package Classes;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Juan
 */
public class Medicamento {
    // Atributos
    private int id_med;
    private String cod_barras;
    private String nombre_comercial;
    private String nombre_generico;
    private String presentacion;
    private String concentracion;
    private int id_lab;                   // ID del laboratorio (FK)
    private String descripcion;
    private BigDecimal precio_publico;    // (Clientes)
    private boolean requiere_receta;
    private BigDecimal precio;             // (Personal)
    private int stock_actual;
    private int stock_minimo;
    private String ubicacion;              // Ubicación en Almacén
    private Date fecha_vencimiento;
    private String proveedor;
    
    // Atributo adicional
    private String nombre_laboratorio;

    // Constructor Vacío
    public Medicamento() {
    }

    // Constructor Lleno
    public Medicamento(int id_med, String cod_barras, String nombre_comercial, 
                      String nombre_generico, String presentacion, String concentracion, 
                      int id_lab, String descripcion, BigDecimal precio_publico, 
                      boolean requiere_receta, BigDecimal precio, int stock_actual, 
                      int stock_minimo, String ubicacion, Date fecha_vencimiento, 
                      String proveedor) {
        this.id_med = id_med;
        this.cod_barras = cod_barras;
        this.nombre_comercial = nombre_comercial;
        this.nombre_generico = nombre_generico;
        this.presentacion = presentacion;
        this.concentracion = concentracion;
        this.id_lab = id_lab;
        this.descripcion = descripcion;
        this.precio_publico = precio_publico;
        this.requiere_receta = requiere_receta;
        this.precio = precio;
        this.stock_actual = stock_actual;
        this.stock_minimo = stock_minimo;
        this.ubicacion = ubicacion;
        this.fecha_vencimiento = fecha_vencimiento;
        this.proveedor = proveedor;
    }

    // Getters & Setters
    public int getId_med() {
        return id_med;
    }

    public void setId_med(int id_med) {
        this.id_med = id_med;
    }

    public String getCod_barras() {
        return cod_barras;
    }

    public void setCod_barras(String cod_barras) {
        this.cod_barras = cod_barras;
    }

    public String getNombre_comercial() {
        return nombre_comercial;
    }

    public void setNombre_comercial(String nombre_comercial) {
        this.nombre_comercial = nombre_comercial;
    }

    public String getNombre_generico() {
        return nombre_generico;
    }

    public void setNombre_generico(String nombre_generico) {
        this.nombre_generico = nombre_generico;
    }

    public String getPresentacion() {
        return presentacion;
    }

    public void setPresentacion(String presentacion) {
        this.presentacion = presentacion;
    }

    public String getConcentracion() {
        return concentracion;
    }

    public void setConcentracion(String concentracion) {
        this.concentracion = concentracion;
    }

    public int getId_lab() {
        return id_lab;
    }

    public void setId_lab(int id_lab) {
        this.id_lab = id_lab;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getPrecio_publico() {
        return precio_publico;
    }

    public void setPrecio_publico(BigDecimal precio_publico) {
        this.precio_publico = precio_publico;
    }

    public boolean isRequiere_receta() {
        return requiere_receta;
    }

    public void setRequiere_receta(boolean requiere_receta) {
        this.requiere_receta = requiere_receta;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public int getStock_actual() {
        return stock_actual;
    }

    public void setStock_actual(int stock_actual) {
        this.stock_actual = stock_actual;
    }

    public int getStock_minimo() {
        return stock_minimo;
    }

    public void setStock_minimo(int stock_minimo) {
        this.stock_minimo = stock_minimo;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getNombre_laboratorio() {
        return nombre_laboratorio;
    }

    public void setNombre_laboratorio(String nombre_laboratorio) {
        this.nombre_laboratorio = nombre_laboratorio;
    }
}