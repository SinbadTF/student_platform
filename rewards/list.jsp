<td>
    <c:choose>
        <c:when test="${reward.issuedBy != null}">
            ${reward.issuedBy.firstName} ${reward.issuedBy.lastName}
        </c:when>
        <c:otherwise>
            Admin
        </c:otherwise>
    </c:choose>
</td>