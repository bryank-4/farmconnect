import supabase from '../config/supabaseSetup.js';

// Signup with role assignment
async function signup(email, password, role, name, location) {
    const { data, error } = await supabase.auth.signUp({
        email,
        password,
    });
    if (error) throw error;

    // Insert user with role
    const { error: insertError } = await supabase
        .from('users')
        .insert({ id: data.user.id, email, role, name, location });
    if (insertError) throw insertError;

    return data;
}

// Login
async function login(email, password) {
    const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
    });
    if (error) throw error;
    return data;
}

// Get current user
async function getCurrentUser() {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return null;

    const { data: userData, error } = await supabase
        .from('users')
        .select('id, email, role, name, location')
        .eq('id', user.id)
        .single();
    if (error) throw error;

    return userData;
}

// Logout
async function logout() {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
}

// Reset Password
async function resetPassword(email, redirectTo) {
    const { data, error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo,
    });
    if (error) throw error;
    return data;
}

export { signup, login, getCurrentUser, logout, resetPassword };