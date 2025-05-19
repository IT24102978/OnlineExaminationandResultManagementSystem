function toggleOptions() {
    const type = document.getElementById('type').value;
    document.getElementById('options-group').style.display = type === 'MCQ' ? 'block' : 'none';
}
document.addEventListener('DOMContentLoaded', toggleOptions);