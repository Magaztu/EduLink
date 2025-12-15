using EduLink.Domain.Entities;

namespace EduLink.Domain.Interfaces;

public interface IPrecioStrategy
{
	decimal Calcular(decimal precioBase, Cliente cliente);
}