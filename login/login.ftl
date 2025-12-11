<#ftl output_format="HTML" auto_esc=true>
<#import "login/template.ftl" as layout>

<@layout.loginLayout; section>
    <#if section = "title">
        ${msg("doLogIn")}
    <#elseif section = "header">
    <#elseif section = "form">
        <#assign logoUrl = (realm.attributes.logoUrl!'')>
        <#assign brandText = (realm.attributes.brandText!realm.displayName!realm.name)>
        <#assign brandLetter = (brandText?has_content)?then(brandText?substring(0,1),'O')>

        <div class="kc-card">
            <div class="kc-card__hero">
                <div class="kc-brand">
                    <#if logoUrl?has_content>
                        <img class="kc-brand__logo-img" src="${logoUrl}" alt="${brandText}">
                    <#else>
                        <div class="kc-brand__logo">${brandLetter}</div>
                    </#if>
                    <div class="kc-brand__text">${brandText}</div>
                </div>
                <h1>${msg("loginAccountTitle","Bem-vindo ao SAC")}</h1>
                <p>${msg("loginAccountDescription","Acesse para acompanhar tickets, licenças e dashboards.")}</p>
            </div>
            <div class="kc-card__form">
                <div class="kc-title">${msg("doLogIn","Entrar")}</div>
                <div class="kc-muted">${msg("loginSubMessage","Use suas credenciais ou SSO habilitado.")}</div>

                <#if message?has_content>
                    <div class="alert ${message.type}">
                        ${kcSanitize(message.summary)?no_esc}
                    </div>
                </#if>

                <#if realm.password>
                    <form id="kc-form-login" onsubmit="return true;" action="${url.loginAction}" method="post">
                        <div class="form-group">
                            <label for="username">${msg("usernameOrEmail","E-mail")}</label>
                            <input tabindex="1" id="username" class="form-control" name="username" value="${login.username!}" type="text" autofocus autocomplete="username" aria-label="${msg('usernameOrEmail')}">
                        </div>
                        <div class="form-group" style="margin-top: 1rem;">
                            <label for="password">${msg("password","Senha")}</label>
                            <input tabindex="2" id="password" class="form-control" name="password" type="password" autocomplete="current-password" aria-label="${msg('password')}">
                        </div>

                        <div class="form-group" style="margin-top: 0.75rem; display: flex; justify-content: space-between; align-items: center;">
                            <div class="checkbox">
                                <label>
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>> ${msg("rememberMe")}
                                </label>
                            </div>
                            <#if realm.resetPasswordAllowed>
                                <a class="btn btn-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword","Esqueci a senha")}</a>
                            </#if>
                        </div>

                        <div class="form-group" style="margin-top: 1.25rem;">
                            <input tabindex="4" class="btn btn-primary btn-block" name="login" id="kc-login" type="submit" value="${msg("doLogIn","Entrar")}">
                        </div>
                    </form>
                </#if>
            </div>
        </div>
    </#if>
</@layout.loginLayout>
