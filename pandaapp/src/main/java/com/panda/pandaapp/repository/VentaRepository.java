package com.panda.pandaapp.repository;

import com.panda.pandaapp.model.Venta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

/**
 * Repository para la entidad Venta.
 * Proporciona métodos para realizar operaciones CRUD y consultas personalizadas.
 */
@Repository
public interface VentaRepository extends JpaRepository<Venta, Long> {

    /**
     * Busca ventas por producto ID
     */
    List<Venta> findByProductoId(Long idProducto);

    /**
     * Busca ventas por medio de pago ID
     */
    List<Venta> findByMedioPagoId(Long idMedioPago);

    /**
     * Busca ventas por fecha específica
     */
    List<Venta> findByFecha(LocalDate fecha);

    /**
     * Busca ventas entre un rango de fechas
     */
    List<Venta> findByFechaBetween(LocalDate fechaInicio, LocalDate fechaFin);

    /**
     * Busca ventas por fecha ordenadas por fecha descendente
     */
    List<Venta> findByFechaOrderByFechaDesc(LocalDate fecha);

    /**
     * Obtiene el total de ventas por producto en un rango de fechas
     */
    @Query("SELECT SUM(v.cantidad * v.precioUnitario) FROM Venta v WHERE v.producto.id = :idProducto AND v.fecha BETWEEN :fechaInicio AND :fechaFin")
    Double getTotalVentasByProductoAndFecha(@Param("idProducto") Long idProducto, 
                                           @Param("fechaInicio") LocalDate fechaInicio, 
                                           @Param("fechaFin") LocalDate fechaFin);

    /**
     * Obtiene las ventas del día actual
     */
    @Query("SELECT v FROM Venta v WHERE DATE(v.fecha) = CURRENT_DATE ORDER BY v.fecha DESC")
    List<Venta> getVentasDelDia();

    /**
     * Cuenta la cantidad total vendida de un producto específico
     */
    @Query("SELECT COALESCE(SUM(v.cantidad), 0) FROM Venta v WHERE v.producto.id = :idProducto")
    Integer getTotalCantidadVendidaByProducto(@Param("idProducto") Long idProducto);
}