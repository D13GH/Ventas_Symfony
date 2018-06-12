<?php

namespace App\Controller;

use DateTime;
use DateTimeZone;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class LoginController extends Controller
{
    /**
     * @Route("/qwerty", name="qwerty")
     */
    public function index(Request $request)
    {
        if ($request->getMethod()=='POST')
        {

            return $this->render('dashboard/index.html.twig', [
                'controller_name' => 'DashboardController',
            ]);
        }

        return $this->render('login/index.html.twig', [
            'controller_name' => 'LoginController',
        ]);
    }

    /**
     * @Route("/fecha", name="fecha")
     */
    public function fecha()
    {
//        $hoy = getdate();
//        print_r($hoy);
//        $dtz = new DateTimeZone("America/Mexico_City"); //Your timezone
//        $now = new DateTime(date("Y-m-d"), $dtz);
//        echo $now->format("Y-m-d H:i:s");


        $fecha = new DateTime(null, new DateTimeZone('America/Mexico_City'));
        $fecha_entrega = new DateTime(null, new DateTimeZone('America/Mexico_City'));
        echo $fecha->format('Y-m-d H:i:s.u') . "\n";

        date_add($fecha_entrega, date_interval_create_from_date_string('10 days'));
        echo $fecha_entrega->format('Y-m-d') . "\n";


        return $this->render('login/index.html.twig', [
            'controller_name' => 'LoginController',
        ]);
    }

}
