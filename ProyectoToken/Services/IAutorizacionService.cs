﻿using ProyectoToken.Custom;

namespace ProyectoToken.Services
{
    public interface IAutorizacionService
    {
        Task<AutorizacionResponse> DevolverToken(AutorizacionRequest autorizacion);

    }
}
