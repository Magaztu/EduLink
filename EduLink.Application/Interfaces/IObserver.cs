namespace EduLink.Application.Interfaces;

public interface IObserver<T>
{
    void OnNext(T evento);
}