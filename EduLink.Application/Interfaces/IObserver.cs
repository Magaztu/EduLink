namespace EduLink.Application.Interfaces;

public interface IDomainObserver<in T> //Se usa in en el generico para mejorar el desacopladoed
{
    void OnNext(T evento);
}