<?php

namespace App\Controller;

use App\Entity\CredencialEmpleado;
use App\Form\CredencialEmpleadoType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/credencial/empleado")
 */
class CredencialEmpleadoController extends Controller
{
    /**
     * @Route("/", name="credencial_empleado_index", methods="GET")
     */
    public function index(): Response
    {
        $credencialEmpleados = $this->getDoctrine()
            ->getRepository(CredencialEmpleado::class)
            ->findAll();

        return $this->render('credencial_empleado/index.html.twig', ['credencial_empleados' => $credencialEmpleados]);
    }

    /**
     * @Route("/new", name="credencial_empleado_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $credencialEmpleado = new CredencialEmpleado();
        $form = $this->createForm(CredencialEmpleadoType::class, $credencialEmpleado);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($credencialEmpleado);
            $em->flush();

            return $this->redirectToRoute('credencial_empleado_index');
        }

        return $this->render('credencial_empleado/new.html.twig', [
            'credencial_empleado' => $credencialEmpleado,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="credencial_empleado_show", methods="GET")
     */
    public function show(CredencialEmpleado $credencialEmpleado): Response
    {
        return $this->render('credencial_empleado/show.html.twig', ['credencial_empleado' => $credencialEmpleado]);
    }

    /**
     * @Route("/{id}/edit", name="credencial_empleado_edit", methods="GET|POST")
     */
    public function edit(Request $request, CredencialEmpleado $credencialEmpleado): Response
    {
        $form = $this->createForm(CredencialEmpleadoType::class, $credencialEmpleado);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('credencial_empleado_edit', ['id' => $credencialEmpleado->getId()]);
        }

        return $this->render('credencial_empleado/edit.html.twig', [
            'credencial_empleado' => $credencialEmpleado,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="credencial_empleado_delete", methods="DELETE")
     */
    public function delete(Request $request, CredencialEmpleado $credencialEmpleado): Response
    {
        if ($this->isCsrfTokenValid('delete'.$credencialEmpleado->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($credencialEmpleado);
            $em->flush();
        }

        return $this->redirectToRoute('credencial_empleado_index');
    }
}
