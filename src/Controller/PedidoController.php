<?php

namespace App\Controller;

use App\Entity\Empleado;
use App\Entity\Estatus;
use App\Entity\IdDevice;
use DateTime;
use DateTimeZone;
use App\Entity\Pedido;
use App\Form\PedidoType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/pedido")
 */
class PedidoController extends Controller
{
    /**
     * @Route("/", name="pedido_index", methods="GET")
     */
    public function index(): Response
    {
        $pedidos = $this->getDoctrine()
            ->getRepository(Pedido::class)
            ->findAll();

        return $this->render('pedido/index.html.twig', ['pedidos' => $pedidos]);
    }

    /**
     * @Route("/new", name="pedido_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {

        $pedido = new Pedido();

        /*
        $fecha = new DateTime(null, new DateTimeZone('America/Mexico_City'));
        $fecha_entrega = new DateTime(null, new DateTimeZone('America/Mexico_City'));

        date_add($fecha_entrega, date_interval_create_from_date_string('10 days'));

        $fecha->format('Y-m-d H:i:s.u');
        $fecha_entrega->format('Y-m-d');

        $pedido->setFecha($fecha);
        $pedido->setFechaEntrega($fecha_entrega);*/

        /**
         * Estatus
         */

        /*
        $estatus = $this->getDoctrine()
            ->getRepository(Estatus::class)
            ->findOneBy([
                'nombre' => 'Procesando'
            ]);

        $pedido->setIdEstatus($estatus);*/



        $form = $this->createForm(PedidoType::class, $pedido);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();

            $title = 'Compra realizada';
            $Empleado = $pedido->getIdEmpleado();
            $Producto = $pedido->getIdProducto();
            $Cliente = $pedido->getIdCliente();
            $Estatus = $pedido->getIdEstatus();
            $message ='';
            $message .= 'Comprado :'.$Cliente->getNombre().' '.$Cliente->getApe().'\n';
            $message .= 'Vendedor :'.$Empleado->getNombre().' '.$Empleado->getApe().'\n';
            $message .= 'Producto :'.$Producto->getNombre().'\n';
            $message .= 'Estatus :'.$Estatus->getNombre();

            $this->push($title,$message);
            $em->persist($pedido);
            $em->flush();

            return $this->redirectToRoute('pedido_index');
        }

        return $this->render('pedido/new.html.twig', [
            'pedido' => $pedido,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="pedido_show", methods="GET")
     */
    public function show(Pedido $pedido): Response
    {
        return $this->render('pedido/show.html.twig', ['pedido' => $pedido]);
    }

    /**
     * @Route("/{id}/edit", name="pedido_edit", methods="GET|POST")
     */
    public function edit(Request $request, Pedido $pedido): Response
    {
        $form = $this->createForm(PedidoType::class, $pedido);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('pedido_edit', ['id' => $pedido->getId()]);
        }

        return $this->render('pedido/edit.html.twig', [
            'pedido' => $pedido,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="pedido_delete", methods="DELETE")
     */
    public function delete(Request $request, Pedido $pedido): Response
    {
        if ($this->isCsrfTokenValid('delete'.$pedido->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($pedido);
            $em->flush();
        }

        return $this->redirectToRoute('pedido_index');
    }

    public function push($title,$body)
    {
        $token1 = $this->getDoctrine()
            ->getRepository(IdDevice::class)
            ->findOneBy(['id'=>1]);

        define('API_ACCESS_KEY','AIzaSyBegkR0j96XSeoNf9LbSraqA3US4140b74');
        $fcmUrl = 'https://fcm.googleapis.com/fcm/send';
        $token = $token1->getToken();

        $notification = [
            'title' =>$title,
            'body' => $body/*,
            'icon' =>'myIcon',
            'sound' => 'mySound'*/
        ];
        $extraNotificationData = ["message" => $notification,"moredata" =>'dd'];


        $fcmNotification = [
            //'registration_ids' => $tokenList, //multple token array
            'to'        => $token, //single token
            'notification' => $notification,
            'data' => $extraNotificationData
        ];

        $headers = [
            'Authorization: key=' . API_ACCESS_KEY,
            'Content-Type: application/json'
        ];


        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$fcmUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
        $result = curl_exec($ch);
        curl_close($ch);


        echo $result;
    }



}
