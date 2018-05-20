<?php

namespace App\Controller;

use App\Entity\Bitacora;
use App\Form\BitacoraType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/bitacora")
 */
class BitacoraController extends Controller
{
    /**
     * @Route("/", name="bitacora_index", methods="GET")
     */
    public function index(): Response
    {
        $bitacoras = $this->getDoctrine()
            ->getRepository(Bitacora::class)
            ->findAll();

        return $this->render('bitacora/index.html.twig', ['bitacoras' => $bitacoras]);
    }

    /**
     * @Route("/new", name="bitacora_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $bitacora = new Bitacora();
        $form = $this->createForm(BitacoraType::class, $bitacora);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($bitacora);
            $em->flush();

            return $this->redirectToRoute('bitacora_index');
        }

        return $this->render('bitacora/new.html.twig', [
            'bitacora' => $bitacora,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="bitacora_show", methods="GET")
     */
    public function show(Bitacora $bitacora): Response
    {
        return $this->render('bitacora/show.html.twig', ['bitacora' => $bitacora]);
    }

    /**
     * @Route("/{id}/edit", name="bitacora_edit", methods="GET|POST")
     */
    public function edit(Request $request, Bitacora $bitacora): Response
    {
        $form = $this->createForm(BitacoraType::class, $bitacora);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('bitacora_edit', ['id' => $bitacora->getId()]);
        }

        return $this->render('bitacora/edit.html.twig', [
            'bitacora' => $bitacora,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="bitacora_delete", methods="DELETE")
     */
    public function delete(Request $request, Bitacora $bitacora): Response
    {
        if ($this->isCsrfTokenValid('delete'.$bitacora->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($bitacora);
            $em->flush();
        }

        return $this->redirectToRoute('bitacora_index');
    }
}
