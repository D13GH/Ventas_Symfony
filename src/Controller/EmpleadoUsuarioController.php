<?php

namespace App\Controller;

use App\Entity\EmpleadoUsuario;
use App\Form\EmpleadoUsuarioType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/empleado/usuario")
 */
class EmpleadoUsuarioController extends Controller
{
    /**
     * @Route("/", name="empleado_usuario_index", methods="GET")
     */
    public function index(): Response
    {
        $empleadoUsuarios = $this->getDoctrine()
            ->getRepository(EmpleadoUsuario::class)
            ->findAll();

        return $this->render('empleado_usuario/index.html.twig', ['empleado_usuarios' => $empleadoUsuarios]);
    }

    /**
     * @Route("/new", name="empleado_usuario_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $empleadoUsuario = new EmpleadoUsuario();
        $form = $this->createForm(EmpleadoUsuarioType::class, $empleadoUsuario);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($empleadoUsuario);
            $em->flush();

            return $this->redirectToRoute('empleado_usuario_index');
        }

        return $this->render('empleado_usuario/new.html.twig', [
            'empleado_usuario' => $empleadoUsuario,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="empleado_usuario_show", methods="GET")
     */
    public function show(EmpleadoUsuario $empleadoUsuario): Response
    {
        return $this->render('empleado_usuario/show.html.twig', ['empleado_usuario' => $empleadoUsuario]);
    }

    /**
     * @Route("/{id}/edit", name="empleado_usuario_edit", methods="GET|POST")
     */
    public function edit(Request $request, EmpleadoUsuario $empleadoUsuario): Response
    {
        $form = $this->createForm(EmpleadoUsuarioType::class, $empleadoUsuario);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('empleado_usuario_edit', ['id' => $empleadoUsuario->getId()]);
        }

        return $this->render('empleado_usuario/edit.html.twig', [
            'empleado_usuario' => $empleadoUsuario,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="empleado_usuario_delete", methods="DELETE")
     */
    public function delete(Request $request, EmpleadoUsuario $empleadoUsuario): Response
    {
        if ($this->isCsrfTokenValid('delete'.$empleadoUsuario->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($empleadoUsuario);
            $em->flush();
        }

        return $this->redirectToRoute('empleado_usuario_index');
    }
}
