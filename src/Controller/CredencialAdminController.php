<?php

namespace App\Controller;

use App\Entity\CredencialAdmin;
use App\Form\CredencialAdminType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/credencial/admin")
 */
class CredencialAdminController extends Controller
{
    /**
     * @Route("/", name="credencial_admin_index", methods="GET")
     */
    public function index(): Response
    {
        $credencialAdmins = $this->getDoctrine()
            ->getRepository(CredencialAdmin::class)
            ->findAll();

        return $this->render('credencial_admin/index.html.twig', ['credencial_admins' => $credencialAdmins]);
    }

    /**
     * @Route("/new", name="credencial_admin_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $credencialAdmin = new CredencialAdmin();
        $form = $this->createForm(CredencialAdminType::class, $credencialAdmin);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($credencialAdmin);
            $em->flush();

            return $this->redirectToRoute('credencial_admin_index');
        }

        return $this->render('credencial_admin/new.html.twig', [
            'credencial_admin' => $credencialAdmin,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="credencial_admin_show", methods="GET")
     */
    public function show(CredencialAdmin $credencialAdmin): Response
    {
        return $this->render('credencial_admin/show.html.twig', ['credencial_admin' => $credencialAdmin]);
    }

    /**
     * @Route("/{id}/edit", name="credencial_admin_edit", methods="GET|POST")
     */
    public function edit(Request $request, CredencialAdmin $credencialAdmin): Response
    {
        $form = $this->createForm(CredencialAdminType::class, $credencialAdmin);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('credencial_admin_edit', ['id' => $credencialAdmin->getId()]);
        }

        return $this->render('credencial_admin/edit.html.twig', [
            'credencial_admin' => $credencialAdmin,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="credencial_admin_delete", methods="DELETE")
     */
    public function delete(Request $request, CredencialAdmin $credencialAdmin): Response
    {
        if ($this->isCsrfTokenValid('delete'.$credencialAdmin->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($credencialAdmin);
            $em->flush();
        }

        return $this->redirectToRoute('credencial_admin_index');
    }
}
