// 軽いパララックス効果（ヒーローエリアの3D感強調）
document.addEventListener('pointermove', (event) => {
  const cards = document.querySelectorAll('.hero-card');
  const orbs = document.querySelectorAll('.orb');
  const hero = document.querySelector('.hero-inner');

  if (!cards.length && !orbs.length && !hero) return;

  const { innerWidth, innerHeight } = window;
  const x = (event.clientX / innerWidth - 0.5) * 2;
  const y = (event.clientY / innerHeight - 0.5) * 2;

  cards.forEach((card, index) => {
    const depth = index === 0 ? 10 : 8;
    const rotateY = -x * depth;
    const rotateX = y * depth;
    card.style.transform = `rotateY(${rotateY}deg) rotateX(${rotateX}deg) translate3d(0, 0, 0)`;
  });

  orbs.forEach((orb, index) => {
    const intensity = index === 0 ? 10 : 14;
    const translateX = -x * intensity;
    const translateY = y * intensity;
    orb.style.transform = `translate3d(${translateX}px, ${translateY}px, 0)`;
  });

  if (hero) {
    const tiltY = -x * 2.5;
    const tiltX = y * 1.8;
    hero.style.transform = `rotateY(${tiltY}deg) rotateX(${tiltX}deg)`;
  }
});

