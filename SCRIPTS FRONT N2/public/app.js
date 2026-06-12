document.addEventListener('DOMContentLoaded', () => {
    obterDadosDashboard();
});

function obterDadosDashboard() {
    const container = document.getElementById('dashboard-container');

    fetch('/api/vagas-eventos')
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição ao servidor.');
            }
            return response.json();
        })
        .then(dados => {
            container.innerHTML = ''; // Limpa o carregando

            if (dados.length === 0) {
                container.innerHTML = '<p class="no-data">Nenhum evento mapeado no momento.</p>';
                return;
            }

            dados.forEach(item => {
                const card = document.createElement('div');
                card.className = 'card';

                const estaLotado = item.Vagas_Restantes <= 0;
                const classeStatus = estaLotado ? 'lotado' : 'disponivel';
                const textoStatus = estaLotado ? '🚫 Inscrições Lotadas' : `✅ ${item.Vagas_Restantes} Vagas Livres`;

                // TRATAMENTO DOS PARTICIPANTES:
                // Se houver participantes, separa por vírgula e cria itens de lista (<li>)
                let listaParticipantesHTML = '';
                if (item.Participantes) {
                    const nomes = item.Participantes.split(', ');
                    listaParticipantesHTML = nomes.map(nome => `<li>👤 ${nome}</li>`).join('');
                } else {
                    listaParticipantesHTML = '<li><em>Nenhum atleta inscrito ainda</em></li>';
                }

                card.innerHTML = `
                    <h3>${item.Evento}</h3>
                    <span class="badge">${item.Modalidade}</span>
                    <div class="vagas-info">
                        <p>Capacidade Máxima: <strong>${item.Capacidade_Maxima} atletas</strong></p>
                        
                        <div class="atleta-container">
                            <strong>Inscritos no Evento:</strong>
                            <ul class="lista-inscritos">
                                ${listaParticipantesHTML}
                            </ul>
                        </div>

                        <div class="status ${classeStatus}">
                            ${textoStatus}
                        </div>
                    </div>
                `;
                
                container.appendChild(card);
            });
        })
        .catch(error => {
            console.error('Erro ao buscar dados:', error);
            container.innerHTML = '<p class="error">❌ Falha ao carregar dados do banco de dados.</p>';
        });
}