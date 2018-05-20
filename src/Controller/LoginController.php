<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class LoginController extends Controller
{
    /**
     * @Route("/", name="login")
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





        /*


        return $this->render('login/index.html.twig', [
            'controller_name' => 'LoginController',
        ]);*/
    }
}
