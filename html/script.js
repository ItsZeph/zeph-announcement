(() => {
  const audio = document.getElementById('annSound');
  window.addEventListener('message', (e) => {
    const d = e.data || {};
    if (d.action === 'play') {
      try { audio.currentTime = 0; audio.volume = 1.0; audio.play(); } catch (e) {}
    } else if (d.action === 'stop') {
      try { audio.pause(); audio.currentTime = 0; } catch (e) {}
    }
  });
})();