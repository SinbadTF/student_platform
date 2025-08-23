/* Main JavaScript for Student Platform */
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap components
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
    
    // Initialize Bootstrap modals
    var modals = document.querySelectorAll('.modal')
    modals.forEach(function(modal) {
        new bootstrap.Modal(modal)
    })
    
    // Points table filtering functionality
    const tableFilter = document.getElementById('tableFilter');
    if (tableFilter) {
        tableFilter.addEventListener('keyup', function() {
            const filterValue = this.value.toLowerCase();
            const table = document.getElementById('pointsTable');
            if (table) {
                const rows = table.querySelectorAll('tbody tr');
                
                rows.forEach(function(row) {
                    let textContent = '';
                    row.querySelectorAll('td').forEach(function(cell) {
                        textContent += cell.textContent + ' ';
                    });
                    
                    if (textContent.toLowerCase().indexOf(filterValue) > -1) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        });
    }
    
    // Reset search form
    const resetButton = document.getElementById('resetSearch');
    if (resetButton) {
        resetButton.addEventListener('click', function() {
            const form = document.getElementById('searchForm');
            if (form) {
                const inputs = form.querySelectorAll('input');
                inputs.forEach(function(input) {
                    input.value = '';
                });
                form.submit();
            }
        });
    }
    
    console.log('Student Platform JS initialized')
})