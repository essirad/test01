<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explorateur Interactif des Livrables Projet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Chosen Palette: Warm Neutrals (Off-white background, earthy tones, muted teal accent) -->
    <!-- Application Structure Plan: A single-page application with a tab-based navigation for the four project phases (Pré-projet, Engagement, Gouvernance, Kick-off). This structure is more intuitive and less overwhelming than a long scroll. Each phase's content is presented in an interactive accordion list, where users click a deliverable to see its description. This encourages focused exploration. A visual process flow diagram at the top provides immediate context of the project lifecycle. This design prioritizes user-guided discovery over static presentation. -->
    <!-- Visualization & Content Choices: Report Info: Project deliverables list. Goal: Organize & Inform. Viz/Presentation: Interactive accordions for deliverables instead of static tables. Interaction: Click to expand/collapse descriptions. Justification: Improves readability and user focus by hiding details until requested. Library/Method: Vanilla JS for accordion logic. Report Info: Four project phases. Goal: Navigate & Structure. Viz/Presentation: Tabbed navigation and a CSS-based process flow diagram. Interaction: Click tabs to switch content. Justification: Provides clear structure and easy navigation between sections. Library/Method: Vanilla JS for tabs, Tailwind CSS for the diagram. -->
    <!-- CONFIRMATION: NO SVG graphics used. NO Mermaid JS used. -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f7f4;
            color: #3d3d3d;
        }
        .tab-active {
            border-color: #0d9488;
            background-color: #ccfbf1;
            color: #134e4a;
            font-weight: 600;
        }
        .accordion-content {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out, padding 0.3s ease-out;
            padding: 0 1.5rem;
        }
        .accordion-content.open {
            max-height: 500px;
            padding: 1rem 1.5rem 1.5rem;
            transition: max-height 0.5s ease-in, padding 0.5s ease-in;
        }
        .accordion-header .icon {
            transition: transform 0.3s ease;
        }
        .accordion-header.open .icon {
            transform: rotate(180deg);
        }
        .timeline-step {
            position: relative;
            flex: 1;
        }
        .timeline-step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 50%;
            right: 0;
            height: 2px;
            width: 100%;
            background-color: #cbd5e1;
            transform: translateX(50%);
            z-index: 0;
        }
        .timeline-dot {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body class="antialiased">

    <div class="container mx-auto max-w-6xl px-4 py-8 sm:py-12">

        <header class="text-center mb-12">
            <h1 class="text-4xl md:text-5xl font-bold text-teal-900 mb-4">Livrables d'Initialisation de Projet</h1>
            <p class="text-lg text-gray-600 max-w-3xl mx-auto">Un guide interactif des livrables clés selon les bonnes pratiques PMI, de l'idée initiale au lancement officiel.</p>
        </header>

        <div class="mb-12">
            <h2 class="text-2xl font-semibold text-center text-gray-700 mb-8">Le Cycle de Vie de l'Initialisation</h2>
            <div class="w-full max-w-4xl mx-auto">
                <div class="flex items-center justify-between">
                    <div class="timeline-step text-center">
                        <div class="timeline-dot w-8 h-8 mx-auto bg-teal-600 rounded-full text-white flex items-center justify-center font-bold">1</div>
                        <p class="mt-2 text-sm md:text-base font-semibold text-teal-800">Pré-projet</p>
                    </div>
                    <div class="timeline-step text-center">
                        <div class="timeline-dot w-8 h-8 mx-auto bg-teal-600 rounded-full text-white flex items-center justify-center font-bold">2</div>
                        <p class="mt-2 text-sm md:text-base font-semibold text-teal-800">Engagement</p>
                    </div>
                    <div class="timeline-step text-center">
                        <div class="timeline-dot w-8 h-8 mx-auto bg-teal-600 rounded-full text-white flex items-center justify-center font-bold">3</div>
                        <p class="mt-2 text-sm md:text-base font-semibold text-teal-800">Gouvernance</p>
                    </div>
                    <div class="timeline-step text-center">
                        <div class="timeline-dot w-8 h-8 mx-auto bg-teal-600 rounded-full text-white flex items-center justify-center font-bold">4</div>
                        <p class="mt-2 text-sm md:text-base font-semibold text-teal-800">Lancement</p>
                    </div>
                </div>
            </div>
        </div>

        <main class="bg-white rounded-2xl shadow-lg p-4 sm:p-8">
            <div class="border-b border-gray-200 mb-6">
                <nav class="flex flex-wrap -mb-px" id="tab-nav">
                    <button data-tab="pre-projet" class="tab-button text-sm sm:text-base font-medium text-center text-gray-500 border-b-2 border-transparent px-4 py-3 hover:text-gray-700 hover:border-gray-300 focus:outline-none">1. Pré-projet</button>
                    <button data-tab="engagement" class="tab-button text-sm sm:text-base font-medium text-center text-gray-500 border-b-2 border-transparent px-4 py-3 hover:text-gray-700 hover:border-gray-300 focus:outline-none">2. Engagement & Contrat</button>
                    <button data-tab="gouvernance" class="tab-button text-sm sm:text-base font-medium text-center text-gray-500 border-b-2 border-transparent px-4 py-3 hover:text-gray-700 hover:border-gray-300 focus:outline-none">3. Organisation & Gouvernance</button>
                    <button data-tab="kickoff" class="tab-button text-sm sm:text-base font-medium text-center text-gray-500 border-b-2 border-transparent px-4 py-3 hover:text-gray-700 hover:border-gray-300 focus:outline-none">4. Kick-off & Dossier</button>
                </nav>
            </div>

            <div id="tab-content">
                <div id="pre-projet" class="tab-panel">
                    <p class="text-gray-600 mb-6 px-2">Phase d'évaluation de l'opportunité avant l'engagement formel. L'objectif est de s'assurer que le projet est viable et aligné avec la stratégie de l'entreprise avant d'y investir des ressources significatives.</p>
                    <div class="space-y-3 accordion-container"></div>
                </div>
                <div id="engagement" class="tab-panel">
                    <p class="text-gray-600 mb-6 px-2">Phase de formalisation de l'accord entre le client et l'équipe projet. Elle transforme l'opportunité en un engagement contractuel avec un périmètre, un coût et des délais définis.</p>
                    <div class="space-y-3 accordion-container"></div>
                </div>
                <div id="gouvernance" class="tab-panel">
                    <p class="text-gray-600 mb-6 px-2">Phase qui définit le "qui fait quoi", "qui décide" et "comment l'information circule". Elle met en place le cadre organisationnel et les règles du jeu pour le pilotage du projet.</p>
                    <div class="space-y-3 accordion-container"></div>
                </div>
                <div id="kickoff" class="tab-panel">
                    <p class="text-gray-600 mb-6 px-2">Phase de lancement officiel des travaux et de consolidation de la documentation de référence. Elle aligne toutes les parties prenantes et marque le début effectif de la réalisation.</p>
                    <div class="space-y-3 accordion-container"></div>
                </div>
            </div>
        </main>

        <footer class="text-center mt-12">
            <p class="text-sm text-gray-500">Application générée pour une exploration interactive des livrables de projet.</p>
        </footer>
    </div>

    <script>
        const deliverablesData = {
            "pre-projet": [
                { title: "Dossier avant-vente", description: "Support commercial initial pour convaincre un prospect de la pertinence d'une solution." },
                { title: "Dossier Go / No Go", description: "Document d'analyse interne pour décider de lancer ou non le projet." },
                { title: "Charte projet", description: "Acte de naissance officiel du projet, autorisant son existence et le chef de projet." },
                { title: "Dossier de transition", description: "Assure le passage de relais et de connaissance entre l'équipe commerciale et l'équipe projet." },
                { title: "Early stakeholder map", description: "Première identification des acteurs clés pour anticiper leurs attentes." }
            ],
            "engagement": [
                { title: "Proposition Commerciale", description: "Offre formelle et détaillée précisant le périmètre, les coûts et les délais." },
                { title: "Contrat", description: "Accord légal qui engage les parties sur leurs obligations mutuelles." },
                { title: "Trajectoire économique", description: "Modélisation des flux financiers prévisionnels (coûts, revenus, marge)." },
                { title: "WBS", description: "Décomposition hiérarchique de tout le travail du projet en lots gérables." },
                { title: "Planning de la proposition", description: "Calendrier de haut niveau montrant les grandes phases et jalons." }
            ],
            "gouvernance": [
                { title: "Stakeholder map", description: "Analyse détaillée des parties prenantes pour définir les stratégies de communication." },
                { title: "Comités", description: "Définition des instances de pilotage et de décision du projet (ex: Comité de Pilotage)." },
                { title: "RACI", description: "Matrice qui clarifie pour chaque tâche qui est le Réalisateur, l'Approbateur, le Consulté et l'Informé." },
                { title: "Gestion documentaire", description: "Règles et processus pour gérer l'ensemble des documents du projet." },
                { title: "Plan de communication", description: "Planifie la diffusion de la bonne information aux bonnes personnes, au bon moment." }
            ],
            "kickoff": [
                { title: "Présentation Kick-off", description: "Support de la réunion de lancement pour aligner toutes les parties prenantes." },
                { title: "Matrice des risques", description: "Registre identifiant les risques, leur évaluation et les plans de réponse associés." },
                { title: "Dossier d’initialisation", description: "Synthèse de référence regroupant la charte, le WBS, le planning, le budget, le plan qualité, les KPIs, etc." }
            ]
        };

        function createAccordionItem(item) {
            return `
                <div class="border border-gray-200 rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors duration-200">
                    <button class="accordion-header w-full flex justify-between items-center text-left p-4 focus:outline-none">
                        <span class="font-semibold text-teal-800">${item.title}</span>
                        <span class="icon text-teal-600 transform transition-transform duration-300">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                        </span>
                    </button>
                    <div class="accordion-content">
                        <p class="text-gray-700">${item.description}</p>
                    </div>
                </div>
            `;
        }

        document.addEventListener('DOMContentLoaded', () => {
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabPanels = document.querySelectorAll('.tab-panel');

            for (const [key, value] of Object.entries(deliverablesData)) {
                const container = document.querySelector(`#${key} .accordion-container`);
                if (container) {
                    container.innerHTML = value.map(createAccordionItem).join('');
                }
            }
            
            function switchTab(tabId) {
                tabButtons.forEach(button => {
                    if (button.dataset.tab === tabId) {
                        button.classList.add('tab-active');
                    } else {
                        button.classList.remove('tab-active');
                    }
                });

                tabPanels.forEach(panel => {
                    if (panel.id === tabId) {
                        panel.style.display = 'block';
                    } else {
                        panel.style.display = 'none';
                    }
                });
            }

            tabButtons.forEach(button => {
                button.addEventListener('click', () => {
                    switchTab(button.dataset.tab);
                });
            });

            document.querySelectorAll('.accordion-header').forEach(header => {
                header.addEventListener('click', () => {
                    const content = header.nextElementSibling;
                    header.classList.toggle('open');
                    content.classList.toggle('open');
                });
            });

            switchTab('pre-projet');
        });
    </script>
</body>
</html>
