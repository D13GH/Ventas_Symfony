<?php

namespace App\Controller;

use App\Entity\Empleado;
use App\Form\EmpleadoType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/empleado")
 */
class EmpleadoController extends Controller
{
    /**
     * @Route("/", name="empleado_index", methods="GET")
     */
    public function index(): Response
    {
        $empleados = $this->getDoctrine()
            ->getRepository(Empleado::class)
            ->findAll();

        return $this->render('empleado/index.html.twig', ['empleados' => $empleados]);
    }

    /**
     * @Route("/new", name="empleado_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $empleado = new Empleado();
        $form = $this->createForm(EmpleadoType::class, $empleado);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($empleado);
            $em->flush();

            return $this->redirectToRoute('empleado_index');
        }

        return $this->render('empleado/new.html.twig', [
            'empleado' => $empleado,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="empleado_show", methods="GET")
     */
    public function show(Empleado $empleado): Response
    {
        return $this->render('empleado/show.html.twig', ['empleado' => $empleado]);
    }

    /**
     * @Route("/{id}/edit", name="empleado_edit", methods="GET|POST")
     */
    public function edit(Request $request, Empleado $empleado): Response
    {
        $form = $this->createForm(EmpleadoType::class, $empleado);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('empleado_edit', ['id' => $empleado->getId()]);
        }

        return $this->render('empleado/edit.html.twig', [
            'empleado' => $empleado,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="empleado_delete", methods="DELETE")
     */
    public function delete(Request $request, Empleado $empleado): Response
    {
        if ($this->isCsrfTokenValid('delete'.$empleado->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($empleado);
            $em->flush();
        }

        return $this->redirectToRoute('empleado_index');
    }
}
