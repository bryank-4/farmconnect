// frontend/src/pages/Profile.tsx
import React from 'react';
import { useAuth } from '../context/AuthContext';

const Profile: React.FC = () => {
    const { user } = useAuth();

    if (!user) return <div>Please log in to view your profile.</div>;

    return (
        <div className="mt-6 p-4 border rounded shadow">
            <h2 className="text-2xl font-bold text-primary mb-4">Profile</h2>
            <p>Name: {user.name}</p>
            <p>Email: {user.email}</p>
            <p>Role: {user.role}</p>
            <p>Location: {user.location}</p>
        </div>
    );
};

export default Profile;