import http from 'k6/http';
import { check, sleep } from 'k6';

// Configuración de la prueba
export const options = {
  // Según la documentación se pueden definir fases de carga
  stages: [
    { duration: '10s', target: 10 }, // (Ramp-up)
    { duration: '20s', target: 20 }, // (Carga sostenida)
    { duration: '10s', target: 0 },  // (Ramp-down)
  ],
  
  // SLAs o umbrales de aceptación
  thresholds: {
    // El 95% de las peticiones deben completarse en menos de 500ms
    http_req_duration: ['p(95)<500'], 
    // La tasa de errores debe ser menor al 1%
    http_req_failed: ['rate<0.01'],
  },
};

const BASE_URL = 'http://127.0.0.1:3000';

export default function () {
  // Página de Inicio (GET /)
  const resHome = http.get(`${BASE_URL}/`);
  
  // Validaciones (Check comprueba el mensaje http)
  check(resHome, {
    'Home status es 200': (r) => r.status === 200,
    'Home carga texto correcto': (r) => r.body.includes('EduLink'),
  });

  // Pausa como en la tarea
  sleep(1);

  // Explorar Servicios (GET /servicios)
  // Este endpoint implica consulta a base de datos
  const resServices = http.get(`${BASE_URL}/servicios`);
  
  // Validaciones
  check(resServices, {
    'Servicios status es 200': (r) => r.status === 200,
    'Lista de servicios visible': (r) => r.body.includes('Explorar Servicios'),
  });

  sleep(1);
}
